import pandas as pd
import gmpy2 as gmp
import os
import numpy as np
from math import ceil
from math import floor
import progressbar
import matplotlib.pyplot as plt
plt.rcParams['figure.dpi'] = 300
from matplotlib.ticker import MultipleLocator
from fractions import Fraction
import warnings
import shelve
import pickle
from multiprocessing import Process, Queue

class TunableTDCSweeper():
    def __init__(
        self, theta_cfg=None, phi_cfg=None, 
        pulsegen=None, dma = None, tdc_len = 128, 
        target_ip = None
    ):
        self.theta_cfg = theta_cfg
        self.phi_cfg = phi_cfg
        self.pulsegen = pulsegen
        self.dma = dma
        self.tdc_len = tdc_len
        self.target_ip = target_ip
        
        # Initialize tuning parameters
        self.tuned_theta_m        = 0
        self.tuned_theta_n        = 0
        self.tuned_theta_c        = 0
        self.tuned_ps_bumps_theta = 0
        self.tuned_theta_avg_rise = 0
        self.tuned_theta_avg_fall = 0
        self.tuned_theta_maxvar_rise = 0
        self.tuned_theta_maxvar_fall = 0
        self.tuned_theta_minvar_rise = 0
        self.tuned_theta_minvar_fall = 0
        self.tuned_theta_delay_ps    = 0

    def __closest_idx__(self, lst, K):
        return min(range(len(lst)), key=lambda i: abs(lst[i]-K))

    def __max_var__(self, min_pd, max_pd, variances, means):
        indices = []
        for idx, mean in enumerate(means):
            if mean >= min_pd and mean <= max_pd:
                indices.append(idx)

        max_var = 0    
        for idx in indices:
            var = variances[idx]
            if var > max_var:
                max_var = var
                max_idx = idx

        return max_idx

    def __min_var__(self,min_pd, max_pd, variances, means):
        indices = []
        for idx, mean in enumerate(means):
            if mean >= min_pd and mean <= max_pd:
                indices.append(idx)

        min_var = 2**20    
        for idx in indices:
            var = variances[idx]
            if var < min_var:
                min_var = var
                min_idx = idx

        return min_idx

    # Trim all 0's/max_pop_count from pop_counts
    #   Return all pop counts and pruned samples/pop_counts
    def __calc_pop_counts__(self, falling_samples, rising_samples):
        pop_counts_rising = [bin(n).count('1') for n in rising_samples] 
        pop_counts_falling = [self.tdc_len - bin(n).count('1') for n in falling_samples]
        return pop_counts_rising, pop_counts_falling

    def __decode_samples__(self, samples):
        '''
        Detect saturated samples (all 1's/all 0's)
            if all samples are saturated to 1 or 0
            return unknown offset
        '''
        return samples[0::4], samples[2::4]
    
    def __firsts_lasts__(self, samples, pol):
        firsts = []
        lasts  = []
        for sample in samples:
            first = 0
            last  = self.tdc_len
            for idx in range(self.tdc_len):
                bv = sample >> idx
                if((bv & 1) == pol ^ 1):
                    break
                first += 1
            firsts.append(first)
            for idx in range(self.tdc_len):
                bv = sample >> ( self.tdc_len - idx - 1 )
                if (bv & 1) == pol:
                    break
                last -= 1
            lasts.append(last)
        return firsts, lasts

    def __calc_firsts_lasts__(self, falling_samples, rising_samples):
        firsts_rising, lasts_rising = self.__firsts_lasts__(rising_samples, 1)
        firsts_falling, lasts_falling = self.__firsts_lasts__(falling_samples, 0)
        return firsts_rising, firsts_falling, lasts_rising, lasts_falling

    # Determine if a sample sequence yielded aligned traces
    def __process_pop_counts__(self, pop_counts_rising, pop_counts_falling):
        mean_rising_pop = np.mean(pop_counts_rising)
        mean_falling_pop = np.mean(pop_counts_falling)
        var_rising_pop = np.var(pop_counts_rising, ddof=1)
        var_falling_pop = np.var(pop_counts_falling, ddof=1)
        return mean_falling_pop, mean_rising_pop, var_falling_pop, var_rising_pop

    def __process_firsts_lasts__(self, firsts_rising, firsts_falling, lasts_rising, lasts_falling):
        mean_firsts_rise = np.mean(firsts_rising)
        var_firsts_rise  = np.var(firsts_rising)
        mean_firsts_fall = np.mean(firsts_falling)
        var_firsts_fall  = np.var(firsts_falling)
        mean_lasts_rise = np.mean(lasts_rising)
        var_lasts_rise  = np.var(lasts_rising)
        mean_lasts_fall = np.mean(lasts_falling)
        var_lasts_fall  = np.var(lasts_falling)
        return mean_firsts_rise, var_firsts_rise, mean_firsts_fall, \
               var_firsts_fall, mean_lasts_rise, var_lasts_rise, \
               mean_lasts_fall, var_lasts_fall

    def sweep_theta(self, theta_cfg_params, theta_samples, sweep_params,
                    tune_param="mid", sweep_data_fh="theta_sweep.csv", debug=0):
        
        tdc_sample_bytes     = ceil(self.tdc_len/8)
        theta_samples_bytes  = theta_samples * tdc_sample_bytes
        max_transfer_samples = floor(self.dma.max_transfer/tdc_sample_bytes)
        delay_lower_bound    = sweep_params["delay_lower_bound"]
        delay_upper_bound    = sweep_params["delay_upper_bound"]
        target_mu            = sweep_params["target rising mu"]
        
        output_dir = os.path.dirname(os.path.realpath(sweep_data_fh))
        isExist = os.path.exists(output_dir)
        if not isExist:
           # Create a new directory because it does not exist
           os.makedirs(output_dir)
        
        theta_sweep_plot_data = {
            "theta mu pop rise"    : [],
            "theta var pop rise"   : [],
            "theta mu pop fall"    : [],
            "theta var pop fall"   : [],
            
            "theta mu first rise"    : [],
            "theta var first rise"   : [],
            "theta mu first fall"    : [],
            "theta var first fall"   : [],
            
            "theta mu last rise"    : [],
            "theta var last rise"   : [],
            "theta mu last fall"    : [],
            "theta var last fall"   : [],
            
            "theta delay (ps)" : [],
            "m"                : [],
            "n"                : [],
            "c"                : [],
            "ps_bumps"         : []
        }
        
        theta_cfg_params = theta_cfg_params.reset_index()
        with progressbar.ProgressBar(max_value=len(theta_cfg_params.index)) as bar:    
            # Sweep through theta PLL configurations to generate a calibrated theta offset
            for index, row in theta_cfg_params.iterrows():
                bar.update(index)
                check = 0
                # Pull config from DF
                m        = int(row['M'])
                n        = int(row['D'])
                c        = int(row['O'])
                ps_bumps = int(row['n'])
                delay_ps = row['delay (ps)']

                if(delay_ps > delay_lower_bound and delay_ps < delay_upper_bound):

                    self.pulsegen.hold_reset()
                    phase_shift = [{"phase_updn":0, "phase_amt":0},{"phase_updn":0,"phase_amt":ps_bumps}]
                    self.theta_cfg.update_all_50(m, n, [c,c], "high", 1, phase_shift)
                    self.pulsegen.reset()
                    
                    
                    # Collect samples, and calculate averages
                    samples = []
                    theta_samples_temp = theta_samples
                    
                    # Sample n_seq sample sequences
                    while(theta_samples_temp > max_transfer_samples):
                        # Prime pulse generator
                        self.pulsegen.prime(0, max_transfer_samples)
                        # Collect TDC traces and append to samples
                        samples = samples + self.dma.get_dma_words(max_transfer_samples, tdc_sample_bytes)
                        theta_samples_temp -= max_transfer_samples
                    
                    # Prime pulse generator
                    self.pulsegen.prime(0, theta_samples_temp)
                    # Collect TDC traces and append to samples
                    samples = samples + self.dma.get_dma_words(theta_samples_temp, tdc_sample_bytes)                    
                    
                    if(debug):
                        for i in range(len(samples)):
                            print(f"IDX{i:5d}: {samples[i]:064x}")

                    # Partition samples into rising and falling
                    falling_samples, rising_samples \
                        = self.__decode_samples__(samples)
                    if(debug):
                        for i in range(int(len(samples)/4)):
                            print(f"Sample Falling IDX{i:5d}: {falling_samples[i]:064x}")
                            print(f" Sample Rising IDX{i:5d}: {rising_samples[i]:064x}")

                    # Calculate pop counts
                    pop_counts_rising, pop_counts_falling \
                        = self.__calc_pop_counts__(falling_samples, rising_samples)
                    if(debug):
                        for i in range(int(len(samples)/4)):
                            print(f"PC Falling IDX{i:5d}: {pop_counts_falling[i]:03d}")
                            print(f" PC Rising IDX{i:5d}: {pop_counts_rising[i]:03d}")
                            
                    # Calculate firsts lasts
                    firsts_rising, firsts_falling, lasts_rising, lasts_falling \
                        = self.__calc_firsts_lasts__(falling_samples, rising_samples)
                    if(debug):
                        for i in range(int(len(samples)/4)):
                            print(f"First Falling IDX{i:5d}: {pop_counts_falling[i]:03d}")
                            print(f" First Rising IDX{i:5d}: {pop_counts_rising[i]:03d}")
                    if(debug):
                        for i in range(int(len(samples)/4)):
                            print(f"Last Falling IDX{i:5d}: {pop_counts_falling[i]:03d}")
                            print(f" Last Rising IDX{i:5d}: {pop_counts_rising[i]:03d}")
                            
                    # Calculate mean of pop counts
                    mean_falling_pop, mean_rising_pop, var_pop_falling, var_pop_rising \
                        = self.__process_pop_counts__(pop_counts_rising, pop_counts_falling )
                    
                    # Calculare mean and var for firsts and lasts
                    mean_firsts_rise, var_firsts_rise, mean_firsts_fall, \
                    var_firsts_fall, mean_lasts_rise, var_lasts_rise, \
                    mean_lasts_fall, var_lasts_fall \
                        = self.__process_firsts_lasts__(firsts_rising, firsts_falling, \
                                                        lasts_rising, lasts_falling)
                    
                    if(debug):
                        print(   f"Avg PC Falling: {mean_falling_pop:03f}")
                        print(   f" Avg PC Rising: {mean_rising_pop:03f}")
                        print(f"Avg First Falling: {mean_firsts_fall:03f}")
                        print(f" Avg First Rising: {mean_firsts_rise:03f}")
                        print(f" Avg Last Falling: {mean_lasts_fall:03f}")
                        print(f"  Avg Last Rising: {mean_lasts_rise:03f}")
                        break

                    theta_sweep_plot_data["theta mu pop rise"].append(mean_rising_pop)
                    theta_sweep_plot_data["theta mu pop fall"].append(mean_falling_pop)
                    theta_sweep_plot_data["theta var pop rise"].append(var_pop_rising)
                    theta_sweep_plot_data["theta var pop fall"].append(var_pop_falling)
                    
                    theta_sweep_plot_data["theta mu first rise"].append(mean_firsts_rise)
                    theta_sweep_plot_data["theta mu first fall"].append(mean_firsts_fall)
                    theta_sweep_plot_data["theta var first rise"].append(var_firsts_rise)
                    theta_sweep_plot_data["theta var first fall"].append(var_firsts_fall)
                    
                    theta_sweep_plot_data["theta mu last rise"].append(mean_lasts_rise)
                    theta_sweep_plot_data["theta mu last fall"].append(mean_lasts_fall)
                    theta_sweep_plot_data["theta var last rise"].append(var_lasts_rise)
                    theta_sweep_plot_data["theta var last fall"].append(var_lasts_fall)
                    
                    theta_sweep_plot_data["m"].append(m)
                    theta_sweep_plot_data["n"].append(n)
                    theta_sweep_plot_data["c"].append(c)
                    theta_sweep_plot_data["ps_bumps"].append(ps_bumps)
                    theta_sweep_plot_data["theta delay (ps)"].append(delay_ps)

        theta_sweep_df = pd.DataFrame(theta_sweep_plot_data)
        theta_sweep_df.to_csv(sweep_data_fh)
    
    def pop_tune_theta(self, theta_cfg_params, theta_samples, sweep_params,
                           tune_rise=False, tuning_param="mid"):
        '''
        This function is for fast theta tuning on popcounts only, it won't yield any plot data
            and has no debug support
        '''
        tdc_sample_bytes     = ceil(self.tdc_len/8)
        theta_samples_bytes  = theta_samples * tdc_sample_bytes
        max_transfer_samples = floor(self.dma.max_transfer/tdc_sample_bytes)
        delay_lower_bound    = sweep_params["delay_lower_bound"]
        delay_upper_bound    = sweep_params["delay_upper_bound"]
        target_mu            = sweep_params["target rising mu"]
        
        if tuning_param == "mid":
            min_mid_diff = self.tdc_len
            mid = self.tdc_len/2
        elif tuning_param == "max var":
            max_var = 0
        elif tuning_param == "min var":
            min_var = self.tdc_len**2
        
        theta_cfg_params = theta_cfg_params.reset_index()
        with progressbar.ProgressBar(max_value=len(theta_cfg_params.index)) as bar:    
            # Sweep through theta PLL configurations to generate a calibrated theta offset
            for index, row in theta_cfg_params.iterrows():
                bar.update(index)
                check = 0
                # Pull config from DF
                m        = int(row['M'])
                n        = int(row['D'])
                c        = int(row['O'])
                ps_bumps = int(row['n'])
                delay_ps = row['delay (ps)']

                if(delay_ps > delay_lower_bound and delay_ps < delay_upper_bound):

                    self.pulsegen.hold_reset()
                    phase_shift = [{"phase_updn":0, "phase_amt":0},{"phase_updn":0,"phase_amt":ps_bumps}]
                    self.theta_cfg.update_all_50(m, n, [c,c], "high", 1, phase_shift)
                    self.pulsegen.reset()
                
                    # Collect samples, and calculate averages
                    samples = []
                    theta_samples_temp = theta_samples

                    # Sample n_seq sample sequences
                    while(theta_samples_temp > max_transfer_samples):
                        # Prime pulse generator
                        self.pulsegen.prime(0, max_transfer_samples)
                        # Collect TDC traces and append to samples
                        samples = samples + self.dma.get_dma_words(max_transfer_samples, tdc_sample_bytes)
                        theta_samples_temp -= max_transfer_samples

                    # Prime pulse generator
                    self.pulsegen.prime(0, theta_samples_temp)
                    # Collect TDC traces and append to samples
                    samples = samples + self.dma.get_dma_words(theta_samples_temp, tdc_sample_bytes)   

                    # Partition samples into rising and falling
                    falling_samples, rising_samples \
                        = self.__decode_samples__(samples)

                    # Calculate pop counts
                    pop_counts_rising, pop_counts_falling \
                        = self.__calc_pop_counts__(falling_samples, rising_samples)

                    if tuning_param == "mid":
                        if tune_rise:
                            mean_pop = np.mean(pop_counts_rising)
                        else:
                            mean_pop = np.mean(pop_counts_falling)
                        if(abs(mean_pop - mid) < min_mid_diff):
                            min_mid_diff = abs(mean_pop - mid)
                            if tune_rise:
                                pop_rise_base = mean_pop
                                pop_fall_base = np.mean(pop_counts_falling)
                            else:
                                pop_rise_base = np.mean(pop_counts_rising)
                                pop_fall_base = mean_pop
                            target_idx = index
                    elif tuning_param == "max var":
                        if tune_rise:
                            var_pop = np.var(pop_counts_rising, ddof=0)
                            print(var_pop)
                        else:
                            var_pop = np.var(pop_counts_falling, ddof=0)
                        if(var_pop > max_var):
                            max_var = var_pop
                            pop_rise_base = np.mean(pop_counts_rising)
                            pop_fall_base = np.mean(pop_counts_falling)
                            target_idx = index
                    elif tuning_param == "min var":
                        if tune_rise:
                            var_pop = np.var(pop_counts_rising, ddof=0)
                        else:
                            var_pop = np.var(pop_counts_falling, ddof=0)
                        if(var_pop < min_var):
                            min_var = var_pop
                            pop_rise_base = np.mean(pop_counts_rising)
                            pop_fall_base = np.mean(pop_counts_falling)
                            target_idx = index
                        
        self.tuned_theta_m        = int(theta_cfg_params.at[target_idx , 'M'])
        self.tuned_theta_n        = int(theta_cfg_params.at[target_idx , 'D'])
        self.tuned_theta_c        = int(theta_cfg_params.at[target_idx , 'O'])
        self.tuned_ps_bumps_theta = int(theta_cfg_params.at[target_idx , 'n'])
        self.tuned_theta_delay_ps = theta_cfg_params.at[target_idx , 'delay (ps)']
        
        self.tuned_theta_avg_rise = pop_rise_base
        self.tuned_theta_avg_fall = pop_fall_base
        
        if tuning_param == "mid":
            if tune_rise:
                tuned_val = self.tuned_theta_avg_rise
            else:
                tuned_val = self.tuned_theta_avg_fall
        elif tuning_param == "max var":
            if tune_rise:
                self.tuned_theta_maxvar_rise = max_var
                tuned_val = self.tuned_theta_maxvar_rise
            else:
                self.tuned_theta_maxvar_fall = max_var
                tuned_val = self.tuned_theta_maxvar_fall
        elif tuning_param == "min_var":
            if tune_rise:
                self.tuned_theta_minvar_rise = min_var
                tuned_val = self.tuned_theta_minvar_rise
            else:
                self.tuned_theta_minvar_fall = min_var
                tuned_val = self.tuned_theta_minvar_fall
        
        edge = "rising" if tune_rise else "falling"
        print(f"Theta tuning complete! {tuning_param} {edge}={tuned_val}")
        print(f"\t          M:{self.tuned_theta_m}")
        print(f"\t          N:{self.tuned_theta_n}")
        print(f"\t          C:{self.tuned_theta_c}")
        print(f"\tPhase Bumps:{self.tuned_ps_bumps_theta}")
        print(f"\t Delay (ps):{self.tuned_theta_delay_ps}")
    
#     def sweep_phi_noprocess(self, phi_cfg_params, theta_samples, mode, perpetual, n_runs, out_dir):
#         # Make dump directory
#         isExist = os.path.exists(out_dir)
#         if isExist:
#             os.rmdir(out_dir)
#         os.makedirs(out_dir)
        
#         # Sweep phi in chunks
#         file_idx = 0
#         total_configs=len(phi_cfg_params.index)
#         chunk_size = int(total_configs/n_runs)
#         with progressbar.ProgressBar(max_value=n_runs) as bar:
#             for index in range(0, total_configs-chunk_size - 1, chunk_size):
#                 bar.update(file_idx)
#                 last = index + chunk_size - 1
#                 phi_cfg_params_subset = phi_cfg_params.iloc[index:last]
#                 # Get subset of configs
#                 out_dict = self.sweep_phi(phi_cfg_params_subset, theta_samples, \
#                                           mode=mode, perpetual=perpetual, process=False)
#                 # Save raw samples to csv
#                 out_df = pd.DataFrame(out_dict)
#                 out_df.to_csv(f"{out_dir}/phi_sweep_samples_{file_idx}.csv")
#                 file_idx += 1
            
    def sweep_phi(self, phi_cfg_params, theta_samples, \
                  mode="bg", perpetual=False, process=True, \
                  out_dir="./", n_packed_runs=100):
        
        isExist = os.path.exists(out_dir)
        if isExist:
            os.rmdir(out_dir)
        os.makedirs(out_dir)
        
        tdc_sample_bytes     = ceil(self.tdc_len/8)
        theta_samples_bytes  = theta_samples * tdc_sample_bytes
        max_transfer_samples = floor(self.dma.max_transfer/tdc_sample_bytes)
        
        if(mode == "bg"):
            if(process == True):
                phi_sweep_plot_data = {
                    "delta mu fall bg"     : [],
                    "delta mu rise bg"     : [],
                    "var fall bg"          : [],
                    "var rise bg"          : [],
                    "phi delay (ps) bg"    : []
                }
            else:
                fh = f"{out_dir}/phi_sweep_samples_{mode}_"
                phi_sweep_plot_data = shelve.open(f"{fh}_0", writeback=False)
                phi_delays  = []
                falling_samples = []
                rising_samples  = []
                ctr = 0
                closed = 0
            # Hold IP in reset during BG measurement
            self.target_ip.hold_reset()
            
        elif(mode == "target"):
            if(process == True):
                phi_sweep_plot_data = {
                    "delta mu fall target" : [],
                    "delta mu rise target" : [],
                    "var fall target"      : [],
                    "var rise target"      : [],
                    "phi delay (ps) target": []
                }
            else:
                fh = f"{out_dir}/phi_sweep_samples_{mode}_"
                phi_sweep_plot_data = shelve.open(f"{fh}_0", writeback=False)
                phi_delays  = []
                falling_samples = []
                rising_samples  = []
                ctr = 0
                closed = 0
            self.target_ip.perpetual=perpetual
            ip_sync_en = 0 if perpetual==True else 1
            if(ip_sync_en):
                self.target_ip.hold_reset()
            else:
                self.target_ip.reset()
        else:
            warnings.warn(f"Unsupported mode {mode}. Exiting!")
            return -1
        
        total_configs = len(phi_cfg_params.index)
        phi_cfg_params = phi_cfg_params.reset_index()
        with progressbar.ProgressBar(max_value=total_configs) as bar:
            # Sweep through theta PLL configurations to generate a calibrated theta offset
            for index, row in phi_cfg_params.iterrows():
                bar.update(index)
                
                # Pull phi config from DF
                m        = int(row['M'])
                n        = int(row['D'])
                c        = int(row['O'])
                ps_bumps = int(row['n'])
                delay_ps = row['delay (ps)']

                # Hold TDC in reset during PLL reconfiguration
                self.pulsegen.hold_reset()
                # Hold theta PLL in reset during phi PLL reconfiguration
                self.theta_cfg.hold_reset()
                # Configure phi PLL
                phase_shift = [{"phase_updn":0, "phase_amt":ps_bumps}]
                self.phi_cfg.update_all_50(m, n, [c], "low", 1, phase_shift)
                # Complete reset sequence of theta PLL
                self.theta_cfg.reset_pll()
                # Reconfigure theta PLL
                phase_shift = [{"phase_updn":0, "phase_amt":0}, \
                               {"phase_updn":0,"phase_amt":self.tuned_ps_bumps_theta}]
                self.theta_cfg.update_all_50( \
                    self.tuned_theta_m, \
                    self.tuned_theta_n, \
                    [self.tuned_theta_c, self.tuned_theta_c], \
                    "high", \
                    1, \
                    phase_shift)
                # Complete reset sequence of TDC
                self.pulsegen.reset()

                if(mode == "bg"):                    
                    # Collect samples
                    samples = []
                    theta_samples_temp = theta_samples

                    # Sample sequences
                    while(theta_samples_temp > max_transfer_samples):
                        # Prime pulse generator
                        self.pulsegen.reset()
                        self.pulsegen.prime(0, max_transfer_samples)
                        # Collect TDC traces and append to samples
                        samples = samples + self.dma.get_dma_words(max_transfer_samples, tdc_sample_bytes)
                        theta_samples_temp -= max_transfer_samples

                    # Prime pulse generator
                    self.pulsegen.reset()
                    self.pulsegen.prime(0, theta_samples_temp)
                    # Collect TDC traces and append to samples
                    samples = samples + self.dma.get_dma_words(theta_samples_temp, tdc_sample_bytes)

                elif(mode=="target"):

                    # Collect samples, and calculate averages
                    samples = []
                    theta_samples_temp = theta_samples

                    # Sample sequences
                    while(theta_samples_temp > max_transfer_samples):
                        # Prepare target IP
                        self.pulsegen.reset()
                        self.target_ip.pre()
                        # Prime pulse generator
                        self.pulsegen.prime(ip_sync_en, max_transfer_samples)
                        # Run target IP
                        self.target_ip.run()
                        # Collect samples
                        samples = samples + self.dma.get_dma_words(max_transfer_samples, tdc_sample_bytes)
                        theta_samples_temp -= max_transfer_samples
                        # Wait for target IP to wrap
                        self.target_ip.post()

                    # Prepare target IP
                    self.pulsegen.reset()
                    self.target_ip.pre()
                    # Prime pulse generator
                    self.pulsegen.prime(ip_sync_en, theta_samples_temp)
                    # Run target IP
                    self.target_ip.run()
                    # Collect samples
                    samples = samples + self.dma.get_dma_words(theta_samples_temp, tdc_sample_bytes)
                    # Wait for target IP to wrap
                    self.target_ip.post()
                
                # Partition samples into rising and falling
                falling_samples, rising_samples \
                    = self.__decode_samples__(samples)
                    
                if(process == True):
                    
                    # Calculate pop counts - saves database space
                    pop_counts_rising, pop_counts_falling \
                        = self.__calc_pop_counts__(falling_samples, rising_samples)
                    
                    # Calculate mean and variance of background pop counts
                    mean_falling_pop, mean_rising_pop, var_pop_falling, var_pop_rising \
                        = self.__process_pop_counts__(pop_counts_rising, pop_counts_falling )

                    phi_sweep_plot_data["phi delay (ps) " + mode].append(delay_ps)
                    phi_sweep_plot_data["delta mu fall " + mode].append(mean_falling_pop_bg - self.tuned_theta_avg_fall)
                    phi_sweep_plot_data["delta mu rise " + mode].append(mean_rising_pop_bg - self.tuned_theta_avg_rise)
                    phi_sweep_plot_data["var fall " + mode].append(var_pop_falling_bg)
                    phi_sweep_plot_data["var rise " + mode].append(var_pop_rising_bg)

                else:
                    phi_delays.append(delay_ps)
                    falling_samples.append(falling_samples)
                    rising_samples.append(rising_samples)
                    if(index == total_configs-1):
                        phi_sweep_plot_data["phi delay (ps) " + mode]  = phi_delays
                        phi_sweep_plot_data["falling samples " + mode] = falling_samples
                        phi_sweep_plot_data["rising samples " + mode]  = rising_samples
                        phi_sweep_plot_data.close()
                    elif(ctr == n_packed_runs-1):
                        phi_sweep_plot_data["phi delay (ps) " + mode]  = phi_delays
                        phi_sweep_plot_data["falling samples " + mode] = falling_samples
                        phi_sweep_plot_data["rising samples " + mode]  = rising_samples
                        phi_sweep_plot_data.close()
                        phi_sweep_plot_data = shelve.open(f"{fh}_{index}", writeback=False)
                        phi_delay = []
                        falling_samples = []
                        rising_samples = []
                        ctr = 0
                    else:
                        ctr += 1
                    
        if(process==True):        
            return phi_sweep_plot_data
        else:
            return 0
                    
    def save_bg_target_data(self, bg={}, target={}, sweep_data_fh="./phi_sweep_data.csv"):
        # Check output dir
        output_dir = os.path.dirname(os.path.realpath(sweep_data_fh))
        isExist = os.path.exists(output_dir)
        if not isExist:
           # Create a new directory because it does not exist
           os.makedirs(output_dir)
        
        # Merge bg and target sweeps
        total = bg
        total.update(target)
        total['diff mu fall']   = []
        total['diff mu rise']   = []
        total['diff var fall']  = []
        total['diff var rise']  = []
        
        # Calculate differences btwn bg and target measurements
        for mu_fpop_tg, mu_fpop_bg, mu_rpop_tg, mu_rpop_bg, \
            vr_fpop_tg, vr_fpop_bg, vr_rpop_tg, vr_rpop_bg in \
            zip(total["delta mu fall target"], total["delta mu fall bg"], \
                total["delta mu rise target"], total["delta mu rise bg"], \
                total["var fall target"], total["var fall bg"],
                total["var rise target"], total["var rise bg"]):
            
            total['diff mu fall'].append(mu_fpop_tg - mu_fpop_bg)
            total['diff mu rise'].append(mu_rpop_tg - mu_rpop_bg)
            total['diff var fall'].append(vr_fpop_tg - vr_fpop_bg)
            total['diff var rise'].append(vr_rpop_tg - vr_rpop_bg)
        
        # Save
        phi_sweep_df = pd.DataFrame(total)
        phi_sweep_df.to_csv(sweep_data_fh)

    def __trim_theta_sweep__(self, thetas, metrics, variances):
        # Find first zero position
        init = metrics.index(0)
        # Find first occurence of maximum value
        end = metrics.index(self.tdc_len)
        # Trim
        thetas_trim = thetas[init:end]
        metrics_trim = metrics[init:end]
        variances_trim = variances[init:end] 
        # Adjust theta (0 == first_0)
        min_theta = min(thetas_trim)
        thetas_trim = [x - min_theta for x in thetas_trim]
        print(f"Arrival delay is {min_theta}")
        # Normalize variances for vertical line plot
        max_len = self.tdc_len * 0.05
        max_vars = max(variances_trim)
        min_vars = min(variances_trim)
        span_vars = max_vars - min_vars
        min_var_ys = []
        max_var_ys = []
        
        for vrnc, metric in zip(variances_trim, metrics_trim):
            half_len = (max_len * (vrnc/span_vars))/2
            min_var_ys.append(metric - half_len)
            max_var_ys.append(metric + half_len)
        return thetas_trim, metrics_trim, min_var_ys, max_var_ys
    
    def __plot_formatted_theta_sweep__(
        self, ax, label, thetas,
        variances_fall, variances_rise,  
        metrics_fall, metrics_rise,
        metric_label,
        var_lines=True, linewidth = 0.5):
        
        thetas_trim, metrics_trim, min_var_ys, max_var_ys \
            = self.__trim_theta_sweep__(thetas, metrics_fall, variances_fall)
        
        ax.plot(thetas_trim, metrics_trim, color = 'red', label = label + " Falling Transition", linewidth = linewidth)
        if(var_lines):
            for theta, min_var_y, max_var_y in zip(thetas_trim, min_var_ys, max_var_ys):
                ax.vlines(x = theta, ymin = min_var_y, ymax = max_var_y,
                           colors = 'red', linewidth = 0.5)
                
        thetas_trim, metrics_trim, min_var_ys, max_var_ys \
            = self.__trim_theta_sweep__(thetas, metrics_rise, variances_rise)
        
        ax.plot(thetas_trim, metrics_trim, color = 'green', label = label + " Rising Transition", linewidth = linewidth)
        if(var_lines):
            for theta, min_var_y, max_var_y in zip(thetas_trim, min_var_ys, max_var_ys):
                ax.vlines(x = theta, ymin = min_var_y, ymax = max_var_y,
                           colors = 'green', linewidth = 0.6)
                
        ax.grid(axis='y', which='major', color='gray', linestyle='-')
        ax.grid(axis='y', which='minor', color='gray', linestyle='--')
        
        major_ticks = np.arange(0, self.tdc_len + 1, self.tdc_len/8)
        minor_ticks = np.arange(0, self.tdc_len + 1, self.tdc_len/16)
        
        ax.set_yticks(major_ticks)
        ax.set_yticks(minor_ticks, minor=True)

        ax.legend(loc = "upper left")
        ax.set_ylabel(metric_label)
        
    def plot_theta_sweep_results(self, sweep_data_fh):
        # Import theta sweep data
        theta_sweep_df = pd.read_csv(sweep_data_fh)
        theta_sweep_dict  = theta_sweep_df.to_dict(orient='list')
        thetas = theta_sweep_dict["theta delay (ps)"]
        # Plot first propagation metric results
        fall_first = theta_sweep_dict["theta mu first fall"]
        fall_vars_first = theta_sweep_dict["theta var first fall"]
        rise_first = theta_sweep_dict["theta mu first rise"]
        rise_vars_first = theta_sweep_dict["theta var first rise"]
        plt.clf()
        fig, (ax1) = plt.subplots(1)
        fig.set_size_inches(7, 3)
        plt.figure(dpi=300)
        self.__plot_formatted_theta_sweep__( \
            ax1, "DE10-Nano", thetas, \
            fall_vars_first, rise_vars_first, \
            fall_first, rise_first, "First Transition")
        # Plot last propagation metric results
        fall_last = theta_sweep_dict["theta mu last fall"]
        fall_vars_last = theta_sweep_dict["theta var last fall"]
        rise_last = theta_sweep_dict["theta mu last rise"]
        rise_vars_last = theta_sweep_dict["theta var last rise"]
        plt.clf()
        fig, (ax1) = plt.subplots(1)
        fig.set_size_inches(7, 3)
        plt.figure(dpi=300)
        self.__plot_formatted_theta_sweep__( \
            ax1, "DE10-Nano", thetas, \
            fall_vars_last, rise_vars_last, \
            fall_last, rise_last, "Last Transition")
        #Plot Hamming Weight propagation metric results
        fall_pop = theta_sweep_dict['theta mu pop fall']
        fall_vars_pop = theta_sweep_dict["theta var pop fall"]
        rise_pop = theta_sweep_dict['theta mu pop rise']
        rise_vars_pop = theta_sweep_dict["theta var pop rise"]
        plt.clf()
        fig, (ax1) = plt.subplots(1)
        fig.set_size_inches(7, 3)
        plt.figure(dpi=300)
        self.__plot_formatted_theta_sweep__( \
            ax1, "DE10-Nano", thetas, \
            fall_vars_pop, rise_vars_pop, \
            fall_pop, rise_pop, "Hamming Weight")
        ax1.set_xlabel(r"$\theta$ ps")

    def __phi_sweep_ps_to_rad__(self, delays, target_f_mhz):
        target_pll_frequency = target_f_mhz*10**6
        target_pll_period_ps = (1/target_pll_frequency)*10**12
        delays_rad = []
        for delay in delays:
            delays_rad.append((delay/target_pll_period_ps) * 2 * math.pi)
    
    def __phi_sweep_ticks__(self, ax, n_ticks, target_f_mhz, n_pi):
        target_ns = (1/(target_f_mhz*10**6))*10**9
        denom = n_ticks*n_pi
        mult = 1/denom
        rad_ticks = [mult * n * n_pi * math.pi for n in range(n_ticks + 1)]
        ns_ticks = [mult*target_ns*n for n in range(n_ticks + 1)]
        ax.set_xticks(ns_ticks) 
        fracs = [Fraction(n*n_pi/denom) for n in range(n_ticks + 1)]
        str_ticks = []
        for frac, ns in zip(fracs, ns_ticks):
            if(frac.denominator == 1):
                str_tick = fr"(${frac.numerator}\pi$, {ns})"
            elif(frac.numerator == 1):
                str_tick = fr"($\frac{{\pi}}{{{frac.denominator}}}$, {ns})"
            else:
                str_tick = fr"($\frac{{{frac.numerator}}}\pi}}{{{frac.denominator}}}$, {ns})"
            str_ticks.append(str_tick)
        ax.set_xticklabels(str_ticks)
    
    def __phi_subplot__(self, ax, delays_rad, bg, label_bg, target, label_targ, ylim):
        ax.plot(delays_rad, bg, label=label_bg, linewidth=0.5)
        ax.plot(delays_rad, target, label=label_targ, linewidth=0.5)
        ax.set_ylim()
        self.__phi_sweep_ticks__(ax, n_ticks, target_f_mhz, n_pi)
        
    def plot_phi_sweep_data(self, sweep_data_fh, target_f_mhz):
        phi_sweep_df = pd.read_csv(sweep_data_fh)
        phi_sweep_dict  = phi_sweep_df.to_dict(orient='list')
        delays_rad = self.__phi_sweep_ps_to_rad__(phi_sweep_dict["phi delay (ps) target"], target_f_mhz)
        plt.clf()
        fig, (ax1, ax2, ax3, ax4, ax5, ax6, ax7, ax8) = plt.subplots(8, sharex=True)
#         self.__phi_subplot__(ax=ax1, 
#                              delays_rad=delays_rad,
#                              bg=,
#                              label_bg=,
#                              target=,
#                              label_targ=,
#                              ylim=[]
#                             )
        