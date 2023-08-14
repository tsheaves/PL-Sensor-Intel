from ..pd_ip import pd_ip

class  altera_msgdma():
   def __init__(
        self, component_dict={}, mmio=None
    ):
        self.dma_csr_inst_name = component_dict["CSR_COMPONENT_NAME"]
        self.dma_csr_inst_type = component_dict["CSR_COMPONENT_TYPE"]
        self.dma_csr_base = component_dict["CSR_BASE"]
        self.dma_csr_span = component_dict["CSR_SPAN"]
        self.dma_csr_end = component_dict["CSR_END"]
        self.dma_descr_inst_name = component_dict["DESCRIPTOR_SLAVE_COMPONENT_NAME"]
        self.dma_descr_inst_type = component_dict["DESCRIPTOR_SLAVE_COMPONENT_TYPE"]
        self.dma_descr_base = component_dict["DESCRIPTOR_SLAVE_BASE"]
        self.dma_descr_span = component_dict["DESCRIPTOR_SLAVE_SPAN"]
        self.dma_descr_end = component_dict["DESCRIPTOR_SLAVE_END"]
