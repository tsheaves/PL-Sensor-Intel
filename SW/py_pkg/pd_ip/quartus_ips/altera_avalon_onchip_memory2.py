import sys
# setting path
sys.path.append('../../pd_ip')
# importing
from pd_ip.pd_ip import pd_ip
import warnings
import time
import math

class altera_avalon_onchip_memory2(pd_ip):
    def __init__(
        self, ip_dict={}, ifc_base=0x0000, mmio_path="",
        mmio_init=True
    ):
        super().__init__(ip_dict, ifc_base, mmio_path, mmio_init)
        
