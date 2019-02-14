from ..pd_ip import pd_ip
import os
import warnings
class  altera_msgdma():
    def __init__(
        self, component_dict={}, ifc_base=0x0000, mmio_path="", mmio_init=True,
        dma_fh=""
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
        self.max_transfer = component_dict["DESCRIPTOR_SLAVE_MAX_BYTE"] 
        self.dma_fh = dma_fh

    def get_dma_words(self, num_words, word_bytes):
        num_bytes = word_bytes*(num_words)
        if(num_bytes > self.max_transfer):
            warnings.warn(f"Warning: Requested DMA transfer of {num_bytes}B too large! Max is {self.max_transfer}.")
        # Get data
        words = os.read(self.dma_fh, num_bytes)
        # Divide return characters into words
        chunks, chunk_size = len(words), len(words)//(num_words)
        # Slice words
        words = [words[i:i+chunk_size] for i in range(0, chunks, chunk_size) ]
        # Convert to unisigned integers
        words_uint = []
        for word in words:
            word_uint = int.from_bytes(word, byteorder='big', signed=False)
            words_uint.append(word_uint)
        return words_uint
        