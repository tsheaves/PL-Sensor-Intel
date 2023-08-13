#include "msgdma.h"

/* Utilitary functions */
static void setbit_reg32(volatile void __iomem *reg, u32 mask) {
	u32 val = ioread32(reg);

	iowrite32(val | mask, reg);
}

static void clearbit_reg32(volatile void __iomem *reg, u32 mask) {
	u32 val = ioread32(reg);

	iowrite32((val & (~mask)), reg);
}

static void
msgdma_reset(struct msgdma_reg *reg)
{
    setbit_reg32(&reg->csr_ctrl, RESET_DISPATCHER);
    while(ioread32(&reg->csr_status) & RESETTING);
}

static void
msgdma_push_descr(
    struct msgdma_reg *reg, 
    dma_addr_t rd_addr, 
    dma_addr_t wr_addr, 
    u32 len, 
    u32 ctrl)
{
    iowrite32(rd_addr, &reg->desc_read_addr);
    iowrite32(wr_addr, &reg->desc_write_addr);
    iowrite32(len, &reg->desc_len);
    iowrite32(ctrl | GO, &reg->desc_ctrl);
}

static int
msgdma_open(struct inode *node, struct file *f) 
{
    // TODO : protect single openness
    struct msgdma_data *data;

    data = container_of(node->i_cdev, struct msgdma_data, cdev);
    f->private_data = data;

    return 0;
}

static int
msgdma_release(struct inode *node, struct file *f) 
{
    return 0;
}

static ssize_t
msgdma_read(struct file *f, char __user *ubuf, size_t len, loff_t *off)
{
    struct msgdma_data *data;
    dma_addr_t rd_addr;
    size_t to_read;
    ssize_t read_ret;
    int ret;

    data = (struct msgdma_data*)f->private_data;

    read_ret = len > DMA_BUF_SIZE ? DMA_BUF_SIZE : len;
    to_read = read_ret;

    /* Initiate transfer */
    rd_addr = data->dma_buf_rd_handle;
    data->rd_in_progress = 1;
    while(to_read > MSGDMA_MAX_TX_LEN) {
        msgdma_push_descr(
            data->msgdma1_reg,
            0,
            rd_addr,
            MSGDMA_MAX_TX_LEN,
            0
        );

        to_read -= MSGDMA_MAX_TX_LEN;
        rd_addr += MSGDMA_MAX_TX_LEN;
    }
    /* Last descriptor sends an IRQ */
    msgdma_push_descr(
        data->msgdma1_reg,
        0,
        rd_addr,
        to_read,
        TX_COMPLETE_IRQ_EN
    );

    /* Wait for transmission to complete */
    ret = wait_event_interruptible_timeout(
        data->rd_complete_wq, 
        !data->rd_in_progress, 
        TX_TIMEOUT);

    if(ret < 0) return -ERESTARTSYS;
    if(ret == 0) return -EIO; // We have a timeout

    if(copy_to_user(ubuf, data->dma_buf_rd, read_ret) != 0)
        return -EFAULT;

    return read_ret;
}

static irqreturn_t 
msgdma_irq_handler(int irq, void *dev_id)
{

    struct msgdma_reg *msgdma1_reg;

    struct msgdma_data *data = (struct msgdma_data*)dev_id;

    msgdma1_reg = data->msgdma1_reg;

    if(ioread32(&msgdma1_reg->csr_status) & IRQ) {
        setbit_reg32(&msgdma1_reg->csr_status, IRQ);
        data->rd_in_progress = 0;
        wake_up_interruptible(&data->rd_complete_wq);
    }

    return IRQ_HANDLED;
}

static int 
msgdma_register_chrdev(struct msgdma_data *data)
{
    int ret = 0;

    ret = alloc_chrdev_region(&data->dev_id, 0, 1, DEV_NAME);
    if(ret < 0) {
        pr_err("Character device region allocation failed\n");
        goto _ret;
    }

    /* Actual registering of the device. At this point it must be 
     * fully initialized */
    cdev_init(&(data->cdev), &msgdma_fops);
    ret = cdev_add(&(data->cdev), data->dev_id, 1);
    if(ret < 0) {
        pr_err("Character device initialisation failed\n");
        goto _cdev_add_err;
    }

    return 0;

_cdev_add_err:
    unregister_chrdev_region(data->dev_id, 1);

_ret:
    return ret;
}

static void
msgdma_unregister_chrdev(struct msgdma_data *data)
{
    cdev_del(&data->cdev);
    unregister_chrdev_region(data->dev_id, 1);
}

static int
msgdma_probe(struct platform_device *pdev)
{
    struct msgdma_data *data;
    struct resource *res;
    struct resource *region;
    struct device *dev;
    int ret = 0;

    dev = &pdev->dev;

    data = (struct msgdma_data*)devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);    
    if(data == NULL)
        return -ENOMEM;

    platform_set_drvdata(pdev, (void*)data);

    /* Prepare DMA buffers */
    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));

    data->dma_buf_rd = dma_alloc_coherent(
        dev, 
        DMA_BUF_SIZE, 
        &data->dma_buf_rd_handle, 
        GFP_KERNEL);

    if(data->dma_buf_rd == NULL) {
        ret = -ENOMEM;
        goto fail;
    }

    /* Remap IO region of the device */
    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    if(res == NULL) {
        dev_err(&pdev->dev, "io region resource not defined");
        return -ENODEV;
    }

    region = devm_request_mem_region(
        dev, 
        res->start, 
        resource_size(res), 
        dev_name(dev));
    if(region == NULL) {
        dev_err(dev, "mem region not requested");
        return -EBUSY;
    }

    data->msgdma1_reg = devm_ioremap(dev, region->start + MSGDMA1_OFFSET, MSGDMA_MAP_SIZE);
    if(data->msgdma1_reg <= 0) {
        dev_err(dev, "could not remap io region");
        return -EFAULT;
    }

    /* Initialize the device itself */
    msgdma_reset(data->msgdma1_reg);

    setbit_reg32(&data->msgdma1_reg->csr_ctrl, 
        STOP_ON_EARLY_TERM | STOP_ON_ERROR | GLOBAL_INT_EN_MASK);

    data->msgdma1_irq = platform_get_irq(pdev, 1);
    if(data->msgdma1_irq < 0) {
        pr_err("could not get irq number");
        return -ENXIO;
    }

    ret = devm_request_irq(dev, data->msgdma1_irq, msgdma_irq_handler, IRQF_SHARED, "msgdma1", data);
    if(ret < 0) {
        dev_err(dev, "Could not request irq %d", data->msgdma1_irq);
        return ret;
    }

    data->rd_in_progress = 0;
    init_waitqueue_head(&data->rd_complete_wq);

    ret = msgdma_register_chrdev(data);
    if(ret < 0)
        return ret;

    return 0;

fail:
    msgdma_remove(pdev);

    return ret;
}

static int
msgdma_remove(struct platform_device *pdev)
{
    struct msgdma_data *data = (struct msgdma_data*)platform_get_drvdata(pdev);

    msgdma_unregister_chrdev(data);

    dma_free_coherent(
        &pdev->dev, 
        DMA_BUF_SIZE, 
        data->dma_buf_rd, 
        data->dma_buf_rd_handle);

    return 0;
}

static int __init
msgdma_init(void)
{
    return platform_driver_register(&msgdma_driver);
}

static void __exit
msgdma_exit(void)
{
    platform_driver_unregister(&msgdma_driver);
}

subsys_initcall(msgdma_init);
module_exit(msgdma_exit);

MODULE_DESCRIPTION("KRG");
MODULE_AUTHOR("KRG");
MODULE_VERSION("1.0");
MODULE_LICENSE("GPL v2");

