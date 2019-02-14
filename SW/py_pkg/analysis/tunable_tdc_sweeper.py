import pandas as pd
import os
import numpy as np
from math import floor
import progressbar

class TunableTDCSweeper():
    def __init__(
        self, theta_cfg=None, phi_cfg=None, pulsegen=None, dma = None, tdc_len = 128
    ):
        self.theta_cfg = theta_cfg
        self.phi_cfg = phi_cfg
        self.pulsegen = pulsegen
        self.dma = dma
        self.tdc_len = tdc_len

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
        firsts_rising, lasts_rising = firsts_lasts(rising_samples, 1, self.tdc_len)
        firsts_falling, lasts_falling = firsts_lasts(falling_samples, 0, self.tdc_len)
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
        mean_firsts_fall = np.mean(firsts_falling)
        mean_lasts_rise = np.mean(lasts_rising)
        mean_lasts_fall = np.mean(lasts_falling)
        return mean_firsts_rise, mean_firsts_fall, mean_lasts_rise, mean_lasts_fall

    def tune_theta(self, theta_cfg_params, phi_cfg_params,
                    theta_samples, sweep_params, tune_param="mid",
                    sweep_data_fh="theta_sweep.csv", debug=0):
        
        num_seq = floor(theta_samples/self.dma.max_transfer)
        delay_lower_bound = sweep_params["delay_lower_bound"]
        delay_upper_bound = sweep_params["delay_upper_bound"]
        target_mu         = sweep_params["target rising mu"]
        min_pd            = sweep_params["min var prop dist"]
        max_pd            = sweep_params["max var prop dist"]
        
        output_dir = os.path.dirname(os.path.realpath(sweep_data_fh))
        isExist = os.path.exists(output_dir)
        if not isExist:
           # Create a new directory because it does not exist
           os.makedirs(output_dir)
        
        theta_sweep_plot_data = {
            "theta mu rise"    : [],
            "theta var rise"   : [],
            "theta mu fall"    : [],
            "theta var fall"   : [],
            "theta delay (ps)" : [],
            "m"                : [],
            "n"                : [],
            "c"                : [],
            "ps_bumps"         : []
        }
        # with progressbar.ProgressBar(max_value=len(theta_cfg_params.index)) as bar:    
            # Sweep through theta PLL configurations to generate a calibrated theta offset
        for index, row in theta_cfg_params.iterrows():
            # bar.update(index)
            check = 0
            # Pull config from DF
            m        = int(row['M'])
            n        = int(row['D'])
            c        = int(row['O'])
            ps_bumps = int(row['n'])
            delay_ps = row['delay (ps)']

            if(delay_ps > delay_lower_bound and delay_ps < delay_upper_bound):

                self.pulsegen.hold_reset()
                phase_shift = [{"phase_updn":0,"phase_amt":ps_bumps}, {"phase_updn":0, "phase_amt":0}]
                self.theta_cfg.update_all_50(m, n, [c,c], "high", 1, phase_shift)
                self.pulsegen.reset()

                # Collect samples, and calculate averages
                samples = []
                # Sample n_seq sample sequences
                for i in range(num_seq + 1):
                    # Prime pulse generator
                    self.pulsegen.prime(0, theta_samples)
                    # Collect TDC traces and append to samples
                    samples = samples + self.dma.get_dma_words(theta_samples, int(self.tdc_len/8))

                # mmio.write32(offset_pulse_gen_reset, 1)
                if(debug):
                    for i in range(len(samples)):
                        print(f"IDX{i:5d}: {samples[i]:064x}")

                # Partition samples into rising and falling
                falling_samples, rising_samples \
                    = self.__decode_samples__(samples)
                if(debug):
                    for i in range(int(len(samples)/4)):
                        print(f"Falling IDX{i:5d}: {falling_samples[i]:064x}")
                        print(f" Rising IDX{i:5d}: {rising_samples[i]:064x}")

                # Calculate pop counts
                pop_counts_rising, pop_counts_falling \
                    = self.__calc_pop_counts__(falling_samples, rising_samples)
                if(debug):
                    for i in range(int(len(samples)/4)):
                        print(f"PC Falling IDX{i:5d}: {pop_counts_falling[i]:03d}")
                        print(f" PC Rising IDX{i:5d}: {pop_counts_rising[i]:03d}")

                # Calculate mean of pop counts
                mean_falling_pop, mean_rising_pop, var_falling, var_rising \
                    = self.__process_pop_counts__(pop_counts_rising, pop_counts_falling )

                if(debug):
                    print(f"   mu PC Falling: {mean_falling_pop:03f}")
                    print(f"    mu PC Rising: {mean_rising_pop:03f}")
                    break

                theta_sweep_plot_data["theta mu rise"].append(mean_rising_pop)
                theta_sweep_plot_data["theta mu fall"].append(mean_falling_pop)
                theta_sweep_plot_data["theta var rise"].append(var_rising)
                theta_sweep_plot_data["theta var fall"].append(var_falling)
                theta_sweep_plot_data["m"].append(m)
                theta_sweep_plot_data["n"].append(n)
                theta_sweep_plot_data["c"].append(c)
                theta_sweep_plot_data["ps_bumps"].append(ps_bumps)
                theta_sweep_plot_data["theta delay (ps)"].append(delay_ps)
                    
        if(debug == 0):
            theta_sweep_df = pd.DataFrame(theta_sweep_plot_data)
            theta_sweep_df.to_csv(sweep_data_fh)
    
            if tune_param == "mid":
                idx_select     = \
                    self.__closest_idx__(theta_sweep_plot_data["theta mu rise"], target_mu)
            if tune_param == "max var":
                idx_select     = \
                    self.__max_var__(min_pd, max_pd, theta_sweep_plot_data["theta var rise"], \
                            theta_sweep_plot_data["theta mu rise"])
            if tune_param == "min var":
                idx_select     = \
                    self.__max_var__(min_pd, max_pd, theta_sweep_plot_data["theta var rise"], \
                            theta_sweep_plot_data["theta mu rise"])

            theta_avg_rise = theta_sweep_plot_data["theta mu rise"][idx_select]
            theta_avg_fall = theta_sweep_plot_data["theta mu fall"][idx_select]
            theta_m        = theta_sweep_plot_data["m"][idx_select]
            theta_n        = theta_sweep_plot_data["n"][idx_select]
            theta_c        = theta_sweep_plot_data["c"][idx_select]
            ps_bumps_theta = theta_sweep_plot_data["ps_bumps"][idx_select]