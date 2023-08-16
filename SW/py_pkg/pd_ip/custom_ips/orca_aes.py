import sys
# setting path
sys.path.append('../../pd_ip')
# importing
from pd_ip.pd_ip import pd_ip
from Crypto.Cipher import AES
import warnings

class orca_aes(pd_ip):
    def __init__(
        self, ip_dict={}, ifc_base=0x0000, mmio_path="", 
        mmio_init = True, aux_mem=None
    ):
        super().__init__(ip_dict, ifc_base, mmio_path, mmio_init)
        self.reset_pio = reset_pio
        self.aux_mem = aux_mem
        
    def reset(self):
        self.write_csr(0,4,1)
        self.write_csr(0,4,0)
        
    def hold_reset(self):
        self.write_csr(0,4,1)
    
    # Pretty simple because we only reset the CPU to activate and IP-Sync takes care of the rest
    def run(self):
        self.reset()

    def pre(self):
        self.hold_reset()
        
    def post(self):
        timeout = 10000
        while(timeout != 0):
            if(self.aux_mem.read_csr(0x100, 4) == 0xAAAAAAAA):
                break
            elif(self.aux_mem.read_csr(0x100, 4) == 0xDDDDDDDD):
                warnings.warn("Warning: ORCA AES returned failure!")
            timeout -= 1
        if(timeout == 0):
            warnings.warn("Warning: ORCA did not wrap as expected!")
            