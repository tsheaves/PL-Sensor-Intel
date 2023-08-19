import sys
# setting path
sys.path.append('../../pd_ip')
# importing
from pd_ip.pd_ip import pd_ip
from Crypto.Cipher import AES
import warnings
import time

class niosv_aes(pd_ip):
    def __init__(
        self, ip_dict={}, ifc_base=0x0000, mmio_path="", 
        mmio_init = True, periph_mem=None, periph_mem_len=512,
        perpetual=False
    ):
        super().__init__(ip_dict, ifc_base, mmio_path, mmio_init)
        self.periph_mem = periph_mem
        self.periph_mem_len = periph_mem_len
        self.perpetual = perpetual
        
    def reset(self):
        self.write_csr(0,4,1)
        self.write_csr(0,4,0)
        
    def hold_reset(self):
        self.write_csr(0,4,1)
    
    # Pretty simple because we only reset the CPU to activate and IP-Sync takes care of the rest
    def run(self):
        if(self.perpetual == False):
            self.reset()

    def pre(self):
        if(self.perpetual == False):
            self.hold_reset()
    
    def __dump__(self):
        print("######### Memory Dump ############")
        for idx in range(int(self.periph_mem_len/4)):
            addr = idx << 2
            data_val = self.periph_mem.read_csr(idx << 2, 4)
            print(f"@AUXMEM[{addr}]:{data_val}")
            
    def post(self):
        if(self.perpetual == False):
            timeout = 1000
            while(timeout != 0):
                value = self.periph_mem.read_csr(0x0, 4)
                if(value == 0xAAAAAAAA):
                    break
                timeout -= 1
            if(timeout == 0):
                warnings.warn(f"Warning: NIOSV did not wrap as expected!")
                self.__dump__()
            self.hold_reset()