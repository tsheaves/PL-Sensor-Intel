from periphery import MMIO
import math
import pandas as pd
import time

class PLL:
    '''
    PLL class 
    '''

    def __init__(  \
        self, ref_clk=50*10**6, \
        fout=100*10**6, m=32, n=4, \
        c=4, phase=0, mmio_ctrl=None, \
        offset = 0):

        self.ref_clk = ref_clk
        self.fout = fout
        self.phase = phase
        self.m = m
        self.n = n
        self.c = c
        self.mmio_ctrl = mmio_ctrl

class IntelPLL(PLL):
    '''
    Intel PLL class
    '''

    def __init__( \
        self, ref_clk=50*10**6, \
        fout=100*10**6, m=32, n=4, \
        c=4, phase=0, mmio_ctrl=None, \
        offset = 0):
        # Parent PLL init
        PLL.__init__(\
        self, ref_clk=50*10**6, \
        fout=100*10**6, m=32, n=4, \
        c=4, phase=0, mmio_ctrl=None, \
        offset = 0)
        # Intel-specific parameters

def check_pll_lock(mmio, pll_locked_offset, num_plls):
    locked_mask = 0x0
    time.sleep(0.001)
    for i in range(num_plls):
        locked_mask = locked_mask << 0x1
        locked_mask = locked_mask | 0x1
    locked = mmio.read32(pll_locked_offset)
    if(locked & locked_mask):
        return 0
    else:
        print("Error: PLL not locked!")
        return 1

def reset_pll(mmio, pll_reset_offset, pll_locked_offset, num_plls):
    mmio.write32(pll_reset_offset, 0x1)
    time.sleep(0.0015)
    mmio.write32(pll_reset_offset, 0x0)
    return check_pll_lock(mmio, pll_locked_offset, num_plls)

def change_bw_setting(mmio, pll_offset, val):
    pll_offset = pll_offset | (8 << 2)
    mmio.write32(pll_offset, val)

def change_cp_setting(mmio, pll_offset, val):
    pll_offset = pll_offset | (9 << 2)
    mmio.write32(pll_offset, val)

def change_vco_post_div_setting(mmio, pll_offset, val):
    pll_offset = pll_offset | (28 << 2)
    mmio.write32(pll_offset, val)

def calc_cp_lf_setting(m, post_div=1, low_med_high = 2):
    m = int(m)*post_div
    if low_med_high == 0:
        fb = [2, 3, 4, 8, 14, 33, 71, 125, 193]
        cp = [0, 2, 1, 2, 1, 1, 1, 1, 1]
        lf = [8, 9, 8, 8, 7, 6, 4, 3, 2]
    elif low_med_high == 1:
        fb = [2, 3, 4, 8, 14, 33, 71, 125, 193]
        cp = [2, 3, 2, 3, 2, 2, 2, 2, 2]
        lf = [9, 9, 8, 8, 7, 6, 4, 3, 2]
    else:
        fb = [2, 3, 4, 8, 14, 33, 71, 125, 193]
        cp = [3, 4, 3, 4, 3, 3, 3, 3, 3]
        lf = [9, 9, 8, 8, 7, 6, 4, 3, 2]

    idx_sel = 8
    for idx, val in enumerate(fb):
        if(val >= m):
            idx_sel = idx
            break

    lf = lf[idx_sel-1]
    cp = cp[idx_sel-1]

    return cp, lf


def bump_phase(mmio, pll_offset, updn, cntsel, amt, pll_locked_offset, num_plls):

    mode_addr_offset        = 0
    addr_status_offset      = (0x1 << 2)
    addr_start_offset       = (0x2 << 2)
    addr_ps_config_offset   = (0x6 << 2)
    
    check_pll_lock(mmio, pll_locked_offset, num_plls)

    # Configure phase shift
    mmio.write32(addr_ps_config_offset |  pll_offset, ((updn & 0x1) << 21) | ((cntsel & 0x1F) << 16) | (int(amt) & 0xFFFF))
    
    # Start dynamic reconfig
    mmio.write32(addr_start_offset |  pll_offset, 0x1)

    # Continue after confirming phase update
    done = 0
    while(done == 0):
        done = mmio.read32(addr_status_offset |  pll_offset)

    return check_pll_lock(mmio, pll_locked_offset, num_plls)

def modify_m_n(mmio, pll_offset, low_count, high_count, bypass_en, odd_div, m):
    pll_offset = pll_offset | ((0x4 << 2) if m else (0x3 << 2))
    word = ((int(odd_div ) & int(0x1)) << 17) | ((int(bypass_en) & int(0x1)) << 16) | ((int(high_count) & int(0xFF)) << 8) | (int(low_count) & int(0xFF))
    mmio.write32(pll_offset, word)

def modify_c(mmio, pll_offset, low_count, high_count, bypass_en, odd_div, count_sel):
    pll_offset = pll_offset | (0x5 << 2)
    word = count_sel << 18 | ((int(odd_div ) & int(0x1)) << 17) | ((int(bypass_en) & int(0x1)) << 16) | ((int(high_count) & int(0xFF)) << 8) | (int(low_count) & int(0xFF))
    mmio.write32(pll_offset, word)

def check_params(mmio, pll_offset, m_hl, n_hl, c0_hl, c1_hl, lf, cp):
    expected = [m_hl & 0xFFFF, n_hl & 0xFFFF, c0_hl & 0xFFFF, c1_hl & 0xFFFF, lf & 0xF, cp & 0x7]
    measured = []
    offset_m =  pll_offset | (0x4 << 2)
    measured.append(mmio.read32(offset_m) & 0xFFFF)
    offset_n =  pll_offset | (0x3 << 2)
    measured.append(mmio.read32(offset_n) & 0xFFFF)
    offset_c0 =  pll_offset | (0xA << 2)
    measured.append(mmio.read32(offset_c0) & 0xFFFF)
    offset_c1 =  pll_offset | (0xB << 2)
    measured.append(mmio.read32(offset_c1) & 0xFFFF)
    offset_lf =  pll_offset | (0x8 << 2)
    measured.append(mmio.read32(offset_lf) & 0xF)
    offset_cp =  pll_offset | (0x9 << 2)
    measured.append(mmio.read32(offset_cp) & 0x7)
    if(measured != expected):
        print("Measured:" + str(measured))
        print("Expected:" + str(expected))
        return 1
    return 0

def commit_mnc_pll_change(mmio, pll_offset, pll_reset_offset, pll_locked_offset, num_plls):
    # Start dynamic reconfig
    mode_addr_offset      = 0
    addr_status_offset    = (0x1 << 2)
    addr_start_offset     = (0x2 << 2)

    # Start reconfiguration
    mmio.write32(addr_start_offset | pll_offset, 0x1)

    # Confirm reconfig status is okay
    check_pll_lock(mmio, pll_locked_offset, num_plls)

    done = 0
    while(done == 0):
        done = mmio.read32(addr_status_offset | pll_offset)

    # Reccommended reset for re-locking PLL https://www.intel.com/content/www/us/en/docs/programmable/683640/current/design-considerations.html
    return reset_pll(mmio, pll_reset_offset, pll_locked_offset, num_plls)

def low_high_duty_cycle_50(num):
    num = int(num)
    if num % 2 == 0:
        return int(num/2), int(num/2), 0
    else:
        high = math.ceil(num/2)
        return int(high), int(num-high), 1

def config_mnc(
    # MMIO object handle
    mmio,
    # M, N, C counter integer values
    m, n, c_list, 
    # Bandwidth: 0 - low, 1 - med,  2 - high
    bw,
    # Address offset for pll reconfig core
    offst_pll_reconf, 
    # Address offset for pll locked output
    offst_pll_locked,
    # Address offset for pll reset input
    offst_pll_reset):
    
    # Ensure PLL is locked
    check_pll_lock(mmio, offst_pll_locked, 1)
    
    # Set polling mode
    mmio.write32(offst_pll_reconf, 1)
    
    # Calculate PLL counter reconfig register parameters
    m_high, m_low, odd_div_m = low_high_duty_cycle_50(m)
    n_high, n_low, odd_div_n = low_high_duty_cycle_50(n)
    cp, lf                   = calc_cp_lf_setting(m, 1, bw)

    # Setup reconfig registers
    modify_m_n(mmio, offst_pll_reconf, 
                        m_low, m_high, m==1, odd_div_m, 1)
    
    modify_m_n(mmio, offst_pll_reconf, 
                        n_low, n_high, n==1, odd_div_n, 0)
    
    for idx, c in enumerate(c_list):
        c_high, c_low, odd_div_c = low_high_duty_cycle_50(c)
        modify_c(mmio, offst_pll_reconf, c_low, c_high, c==1, odd_div_c, idx)
        
    change_bw_setting(mmio, offst_pll_reconf, lf)
    change_cp_setting(mmio, offst_pll_reconf, cp)
    change_vco_post_div_setting(mmio, offst_pll_reconf, 1)
    
    # Commit PLL updates
    check = commit_mnc_pll_change( mmio, offst_pll_reconf, 
                                   offst_pll_reset, 
                                   offst_pll_locked, 1)
    
    return check

def phase_bump(
    # MMIO object handle
    mmio,
    # Address offset for pll reconfig core
    offst_pll_reconf, 
    # Address offset for pll locked output
    offst_pll_locked,
    # Phase bump amounts
    phase_bump,
    # Up or down
    updwn,
    # Counter select
    cntsel):
    
    if(phase_bump == 0):
        return 0
    
    while(phase_bump > (2**14) ):
        mmio.write32(offst_pll_reconf, 0x1)
        check = bump_phase(mmio, offst_pll_reconf, updwn, cntsel, 
                           (2**14) >> 2, offst_pll_locked, 1)
        phase_bump -= 2**14
    
    mmio.write32(offst_pll_reconf, 0x1)
    check = bump_phase(mmio, offst_pll_reconf, updwn, cntsel, 
                       phase_bump, offst_pll_locked, 1)
    
    return check
