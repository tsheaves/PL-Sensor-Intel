import sys
# setting path
sys.path.append('../../pd_ip')
# importing
from pd_ip.pd_ip import pd_ip
import warnings
import time
import math

class altera_pll_reconfig(pd_ip):
    def __init__(
        self, ip_dict={}, ifc_base=0x0000, mmio_path="",
        mmio_init=True, num_out=1, m=None, n=None, c=[],
        phase_bump=[], post_div=None, bw="", lf=None, 
        reset_pio=None, locked_pio=None, lock_min_time=0.001
    ):
        super().__init__(ip_dict, ifc_base, mmio_path, mmio_init)
        self.reset_pio = reset_pio
        self.locked_pio = locked_pio
        self.lock_min_time = lock_min_time
        self.m = m
        self.num_out = num_out
        self.m_params = {
                "bypass" : None,
                "low" : None,
                "high" : None,
                "odd_div" : None
        }
        self.n = n
        self.n_params = {
                "bypass" : None,
                "low" : None,
                "high" : None,
                "odd_div" : None
        }
        self.c = c
        self.c_params = {
                "bypass" : [None] * num_out,
                "low" : [None] * num_out,
                "high" : [None] * num_out,
                "odd_div" : [None] * num_out,
                "phase_updn" : [None] * num_out,
                "phase_amt" : [None] * num_out
        }

        self.post_div = post_div
        self.bw = bw
        self.lf = lf

    def __prime_polling__(self):
        poll_offset = 0x0
        self.write_csr(poll_offset, 4, 0x1)

    def __wait_ready__(self):
        status_offset = 0x1 << 2
        ready = 0
        while(ready == 0):
            ready = self.read_csr(status_offset, 4)
        return True

    def __commit_pll_changes__(self):
        dyn_reconfig_offset = 0x2 << 2
        # Commit phase bump
        self.write_csr(dyn_reconfig_offset, 4, 0x1)
        self.__wait_ready__()

    def __wait_pll_lock__(self):
        time.sleep(self.lock_min_time)
        if(self.locked_pio == None):
            warning(f"Warning: PLL {ip_dict['COMPONENT_NAME']} does not have an associated locked PIO!")
            return False
        else:
            locked = 0
            while(locked == 0):
                locked = self.locked_pio.read_csr(0, 4)
            return True

    def __update_lf__(self):
        lf_offset = 8 << 2
        if(self.lf >= 0 and self.lf < 2**4):
            self.write_csr(lf_offset, 4, self.lf)
            return 0
        else:
            warning(f"Warning: PLL {ip_dict['COMPONENT_NAME']} cannot drive lf setting of {self.lf}!")
            return -1

    def __update_cp__(self):
        cp_offset = 9 << 2
        if(self.cp >= 0 and self.cp < 2**3):
            self.write_csr(cp_offset, 4, self.cp)
            return 0
        else:
            warning(f"Warning: PLL {ip_dict['COMPONENT_NAME']} cannot drive cp setting of {self.cp}!")
            return -1

    def __update_vco_post_div_setting__(self):
        vco_pd_offset = 28 << 2
        if(self.post_div == 0 or self.post_div == 1):
            self.write_csr(vco_pd_offset, 4, self.post_div)
            return 0
        else:
            warning(f"Warning: PLL {ip_dict['COMPONENT_NAME']} cannot drive cp setting of {self.cp}!")
            return -1

    def __update_pll_advanced_settings__(self):
        m_eff = self.m*self.post_div
        if self.bw == "low":
            fbs = [2, 3, 4, 8, 14, 33, 71, 125, 193]
            cps = [0, 2, 1, 2, 1, 1, 1, 1, 1]
            lfs = [8, 9, 8, 8, 7, 6, 4, 3, 2]
        elif self.bw == "med":
            fbs = [2, 3, 4, 8, 14, 33, 71, 125, 193]
            cps = [2, 3, 2, 3, 2, 2, 2, 2, 2]
            lfs = [9, 9, 8, 8, 7, 6, 4, 3, 2]
        elif self.bw == "high":
            fbs = [2, 3, 4, 8, 14, 33, 71, 125, 193]
            cps = [3, 4, 3, 4, 3, 3, 3, 3, 3]
            lfs = [9, 9, 8, 8, 7, 6, 4, 3, 2]

        for fb, cp_temp, lf_temp in zip(fbs, cps, lfs):
            if(fb >= m_eff):
                self.lf = lf_temp
                self.__update_lf__()
                self.cp = cp_temp
                self.__update_cp__()
                return 0

    def __update_m__(self):
        pll_m_offset = 0x4 << 2
        word = 0
        word = word        | (self.m_params["odd_div"] & 0x1)
        word = (word << 1) | (self.m_params["bypass"] & 0x1)
        word = (word << 8) | (self.m_params["high"] & 0xFF)
        word = (word << 8) | (self.m_params["low"] & 0xFF)
        self.write_csr(pll_m_offset, 4, word)

    def __update_n__(self):
        pll_n_offset = 0x3 << 2
        word = 0
        word = word        | (self.n_params["odd_div"] & 0x1)
        word = (word << 1) | (self.n_params["bypass"] & 0x1)
        word = (word << 8) | (self.n_params["high"] & 0xFF)
        word = (word << 8) | (self.n_params["low"] & 0xFF)
        self.write_csr(pll_n_offset, 4, word)

    def __update_c__(self, cntsel):
        pll_c_offset = 0x5 << 2
        word = 0
        word = (word     ) | (cntsel & 0x1F)
        word = (word << 1) | (self.c_params["odd_div"][cntsel] & 0x1)
        word = (word << 1) | (self.c_params["bypass"][cntsel] & 0x1)
        word = (word << 8) | (self.c_params["high"][cntsel] & 0xFF)
        word = (word << 8) | (self.c_params["low"][cntsel] & 0xFF)
        self.write_csr(pll_c_offset, 4, word)

    def __phase_bump_partial__(self, cntsel, amt):
        phase_bump_offset   = 0x6 << 2

        self.__prime_polling__()

        # Configure word
        word = 0
        word = (word      ) | (self.c_params["phase_updn"][cntsel] & 0x1)
        word = (word << 5 ) | (cntsel & 0x1F)
        word = (word << 16) | (amt & 0xFFFF)

        # Submit phase bump
        self.write_csr(phase_bump_offset, 4, word)

        # Commit phase bump
        self.__commit_pll_changes__()

        # Check lock - probably unneccesary
        self.__wait_pll_lock__()

    def __phase_bump_full__(self, cntsel):
        amt = self.c_params["phase_amt"][cntsel]
        if(amt == 0):
            return 0
        while(amt > ((2**14)-1)):
            self.__phase_bump_partial__(cntsel, ((2**14)-1))
            amt = amt - ((2**14)-1)
        if(amt > 0):
            self.__phase_bump_partial__(cntsel, amt)

    def __calc_low_high_50__(self, num):
        num = int(num)
        if num % 2 == 0:
            odd_div = 0
            return int(num/2), int(num/2), odd_div
        else:
            odd_div = 1
            high = math.ceil(num/2)
            return int(high), int(num-high), odd_div

    def __calc_params_50_all__(self, phase_bumps):
        self.m_params["bypass"] = self.m == 1
        self.n_params["bypass"] = self.n == 1
        self.m_params["high"], self.m_params["low"],  self.m_params["odd_div"] \
            = self.__calc_low_high_50__(self.m)
        self.n_params["high"], self.n_params["low"],  self.n_params["odd_div"] \
            = self.__calc_low_high_50__(self.n)
        self.c_params = {
                "bypass" : [None] * self.num_out,
                "low" : [None] * self.num_out,
                "high" : [None] * self.num_out,
                "odd_div" : [None] * self.num_out,
                "phase_updn" : [None] * self.num_out,
                "phase_amt" : [None] * self.num_out
        }
        for i in range(self.num_out):
            self.c_params["high"][i], self.c_params["low"][i], self.c_params["odd_div"][i] \
                =  self.__calc_low_high_50__(self.c[i])
            self.c_params["bypass"][i] = self.c[i] == 1
            self.c_params["phase_updn"][i] = phase_bumps[i]["phase_updn"]
            self.c_params["phase_amt"][i] = phase_bumps[i]["phase_amt"]
    
    def check_params(self):
        '''
        Check PLL parameters
        '''
        # Check M
        pll_m_offset = 0x4 << 2
        word = 0
        word = word        | (self.m_params["odd_div"] & 0x1)
        word = (word << 1) | (self.m_params["bypass"] & 0x1)
        word = (word << 8) | (self.m_params["high"] & 0xFF)
        word = (word << 8) | (self.m_params["low"] & 0xFF)
        measured = self.read_csr(pll_m_offset, 4)
        if((word  & 0xFFFF) == measured):
            print("M validated")
        else:
            warnings.warn(f"M counter mismatch expectectd 0x{word:08x} got 0x{measured:08x}")
            
        # Check N
        pll_n_offset = 0x3 << 2
        word = 0
        word = word        | (self.n_params["odd_div"] & 0x1)
        word = (word << 1) | (self.n_params["bypass"] & 0x1)
        word = (word << 8) | (self.n_params["high"] & 0xFF)
        word = (word << 8) | (self.n_params["low"] & 0xFF)
        measured = self.read_csr(pll_n_offset, 4)
        if((word & 0xFFFF) == measured ):
            print("N validated")
        else:
            warnings.warn(f"N counter mismatch expectectd 0x{word:08x} got 0x{measured:08x}")
            
        # Check Cs
        cnsel_rd_addr = range(10, 27)
        for cnt in range(self.num_out):
            pll_c_offset = cnsel_rd_addr[cnt] << 2
            word = 0
            word = word        | (self.c_params["odd_div"][cnt] & 0x1)
            word = (word << 1) | (self.c_params["bypass"][cnt] & 0x1)
            word = (word << 8) | (self.c_params["high"][cnt] & 0xFF)
            word = (word << 8) | (self.c_params["low"][cnt] & 0xFF)
            measured = self.read_csr(pll_c_offset, 4)
            if((word & 0xFFFF) == measured ):
                print(f"C[{cnt}] validated!")
            else:
                warnings.warn(f"C[{cnt}] counter mismatch expectectd 0x{word:08x} got 0x{measured:08x}")
        return 0
    
    def __update_all_params_50__(self):
        self.__prime_polling__()
        # Update lf and cp from m
        self.__update_pll_advanced_settings__()
        # Update m and n counter settings
        self.__update_m__()
        self.__update_n__()
        # Commit updates
        self.__commit_pll_changes__()
        # Reset to initiate lock
        self.reset_pll()
        # Update each output c counter
        for cntsel in range(self.num_out):
            self.__prime_polling__()
            self.__update_c__(cntsel)
            self.__commit_pll_changes__()
            self.reset_pll()
        # Automatically performs prime/commit/lock check
        for cntsel in range(self.num_out):
            self.__phase_bump_full__(cntsel)

    def reset_pll(self):
        if(self.reset_pio == None):
            warning(f"Warning: PLL {self.ip_dict['COMPONENT_NAME']} does not have an associated reset PIO!")
            return -1
        else:
            self.reset_pio.write_csr(0, 4, 1)
            self.reset_pio.write_csr(0, 4, 0)
            self.__wait_pll_lock__()
            return 0

    def hold_reset(self):
        if(self.reset_pio == None):
            warning(f"Warning: PLL {self.ip_dict['COMPONENT_NAME']} does not have an associated reset PIO!")
            return -1
        else:
            self.reset_pio.write_csr(0, 4, 1)
            return 0

    def update_all_50(self, m, n, c, bw, post_div, phase_bumps):
        '''
        m and n are integer singletons,
        c is an array of counter integers of size num_out,
        phase_bumps is a list dictionaries of size num_out
            - "phase_updn": 1=up 0=dn
            - "phast_amt" : number of phase bumps (1/8 * T_vco)
        '''
        self.m = m
        self.n = n
        self.c = c
        self.bw = bw
        self.post_div = post_div
        self.__calc_params_50_all__(phase_bumps)
        self.__update_all_params_50__()
