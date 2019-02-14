import pandas as pd
import os
import numpy as np
from math import ceil
from math import floor
import progressbar
import matplotlib.pyplot as plt
plt.rcParams['figure.dpi'] = 300
from matplotlib.ticker import MultipleLocator

class TunableTDCSweeper():
    def __init__(
        self, theta_cfg=None, phi_cfg=None, pulsegen=None, dma = None, tdc_len = 128
    ):
        self.theta_cfg = theta_cfg
        self.phi_cfg = phi_cfg
        self.pulsegen = pulsegen
        self.dma = dma
        self.tdc_len = tdc_len
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

    def __popcount__(self, x):
        return bin(x).count('1')

    # Trim all 0's/max_pop_count from pop_counts
    #   Return all pop counts and pruned samples/pop_counts
    def __calc_pop_counts__(self, falling_samples, rising_samples):
        pop_counts_rising = [] 
        pop_counts_falling = []
        for sample_rise, sample_fall in zip(rising_samples, falling_samples):        
            pop_counts_rising.append(self.__popcount__(sample_rise))
            pop_counts_falling.append(self.tdc_len-self.__popcount__(sample_fall))
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
        var_rising_pop = np.var(pop_counts_rising, ddof=0)
        var_falling_pop = np.var(pop_counts_falling, ddof=0)
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

    def sweep_theta(self, theta_cfg_params, phi_cfg_params,
                    theta_samples, sweep_params, tune_param="mid",
                    sweep_data_fh="theta_sweep.csv", debug=0):
        
        tdc_sample_bytes     = ceil(self.tdc_len/8)
        theta_samples_bytes  = theta_samples * tdc_sample_bytes
        max_transfer_samples = floor(self.dma.max_transfer/tdc_sample_bytes)
        delay_lower_bound    = sweep_params["delay_lower_bound"]
        delay_upper_bound    = sweep_params["delay_upper_bound"]
        target_mu            = sweep_params["target rising mu"]
        min_pd               = sweep_params["min var prop dist"]
        max_pd               = sweep_params["max var prop dist"]
        
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
    
    def pop_tune_theta(self, theta_cfg_params, phi_cfg_params, 
                       theta_samples, sweep_params, tune_rise=False, tune_param="mid"):
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
        min_pd               = sweep_params["min var prop dist"]
        max_pd               = sweep_params["max var prop dist"]
        
        if tuning_param == "mid":
            min_mid_diff = self.tdc_len
            mid = self.tdc_len/2
        elif tuning_param == "max var":
            max_var = 0
        elif tuning_param == "min_var":
            min_var = self.tdc_len**2
        
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
                
                # Calculate pop counts
                pop_counts_rising, pop_counts_falling \
                    = self.__calc_pop_counts__(falling_samples, rising_samples)
                
                if tuning_param == "mid":
                    if tune_rise:
                        mean_pop = np.mean(pop_counts_rising)
                    else:
                        mean_pop = np.mean(pop_counts_falling)
                    if((mean_pop - mid) < min_mid_diff):
                        min_mid_diff = mean_pop
                        target_idx = index
                elif tuning_param == "max var":
                    if tune_rise:
                        var_pop = np.var(pop_counts_rising, ddof=0)
                    else:
                        var_pop = np.var(pop_counts_falling, ddof=0)
                    if(var_pop > max_var):
                        max_var = var_pop
                        target_idx = index
                elif tuning_param == "min_var":
                    if tune_rise:
                        var_pop = np.var(pop_counts_rising, ddof=0)
                    else:
                        var_pop = np.var(pop_counts_falling, ddof=0)
                    if(var_pop < min_var):
                        min_var = var_pop
                        target_idx = index
                        
        target_row                = theta_cfg_params.iloc[[4]]
        self.tuned_theta_m        = target_row["m"]
        self.tuned_theta_n        = target_row["n"]
        self.tuned_theta_c        = target_row["c"]
        self.tuned_ps_bumps_theta = target_row["n"]
        
        if tuning_param == "mid":
            if tune_rise:
                self.tuned_theta_avg_rise = min_mid_diff + mid
            else:
                self.tuned_theta_avg_fall = min_mid_diff + mid
        elif tuning_param == "max var":
            if tune_rise:
                self.tuned_theta_maxvar_rise = max_var
            else:
                self.tuned_theta_maxvar_fall = max_var
        elif tuning_param == "min_var":
            if tune_rise:
                self.tuned_theta_minvar_rise = min_var
            else:
                self.tuned_theta_minvar_fall = min_var
                
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
