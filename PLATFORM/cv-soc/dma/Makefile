DRV_NAME		=msgdma

KERNEL_SRC		=/home/sheaves/de10nano-wd/linux-socfpga # TODO : modify path
ARCH			=arm
CROSS_COMPILE		=/home/sheaves/de10nano-wd/gcc-arm-10.3-2021.07-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-

obj-m			+=$(DRV_NAME).o

all:
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL_SRC) M=$(PWD) modules

install: all
	sudo cp $(DRV_NAME).ko /srv/nfs/de1_rootfs/home/root 

clean:
	make -C $(KERNEL_SRC) M=$(PWD) clean
