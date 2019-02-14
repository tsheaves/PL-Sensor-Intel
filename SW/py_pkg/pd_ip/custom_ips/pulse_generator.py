import sys
# setting path
sys.path.append('../../pd_ip')
# importing
from pd_ip.pd_ip import pd_ip

class pulse_generator(pd_ip):
    
    def __init__(
        self, ip_dict={}, ifc_base=0x0000, mmio_path="",
        mmio_init=True, reset_pio=None
    ):
        super().__init__(ip_dict, ifc_base, mmio_path, mmio_init)
        self.reset_pio = reset_pio

    def prime(self, ip_sync_en=0, num_samples=0):
        pg_nsamples_addr = 0
        pg_ipsync_en_addr = 4
        self.write_csr(pg_ipsync_en_addr, 4, ip_sync_en) 
        self.write_csr(pg_nsamples_addr, 4, num_samples) 
        
    def reset(self):
        self.reset_pio.write_csr(0, 4, 1)
        self.reset_pio.write_csr(0, 4, 0)
        
    def hold_reset(self):
        self.reset_pio.write_csr(0, 4, 1)
