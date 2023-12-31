from itertools import product
import pandas as pd
import numpy as np
import math

class PLLPreProcessor():

    def __init__(
        self, vendor='intel', vco_max=1600*10**6, \
        vco_min=600*10**6, Ms=range(1, 512), \
        Ds=range(1, 512), Os=range(1,512), \
        pfd_min=5*10**6, pfd_max=25*10**6
    ):
        self.vendor  = vendor.lower()
        self.vco_max = vco_max
        self.vco_min = vco_min
        self.Ms = Ms
        self.Ds = Ds
        self.Os = Os
        self.max_o = max(Os)
        self.pfd_min = pfd_min
        self.pfd_max = pfd_max
    
    def is_between(self, a, x, b):
        return min(a, b) <= x <= max(a, b)

    def __calc_stability_metric__(self, f_pfd, f_vco, O):
        '''
        TODO check this
            Weigh the following equally:
            - Phase Noise: Higher O and Fvco is better
            -      Jitter: Higher Fpfd is better
        '''
        prop_max_pfd = f_pfd/self.pfd_max
        prop_max_vco = f_vco/self.vco_max
        prop_max_o = O/self.max_o 
        return prop_max_pfd + prop_max_vco + prop_max_o
    
    def gen_pll_params( self, \
        ref_clk  = 50 * 10 ** 6, \
        out_min = 100 * 10 ** 6, out_max = 100 * 10 ** 6, \
        delay_lower = 0 * 10 ** -12, \
        delay_upper = 6000 * 10 ** -12, \
        target_clk = 25*10**6 
    ):

        n_cycles = math.ceil(2*out_max/target_clk)
        
        # Fine Grain Divider setting
        fgdiv = 56 if self.vendor == 'xilinx' else 8
        
        # Take the cross product and filter to keep all M/D values that produce valid Fvco frequencies
        vcos = [(M,D) for (M,D) in product(self.Ms, self.Ds) if self.is_between(self.vco_min, ref_clk * M / D, self.vco_max)]
        
        arr = []
        for (M, D) in vcos:
            for O in self.Os:
                # Compute the output frequency from the current parameters
                out = ref_clk * M/(D * O)
                if( (out > out_max) or (out < out_min) ):
                    continue # Skip loop iteration
                for n in range (0, round(n_cycles * fgdiv * ref_clk * M / (D * out))):
                    delay = n_cycles*(D * O / (ref_clk * M)) - n / (fgdiv * out * O)                   
                    if(self.is_between(delay_lower, delay, delay_upper)):
                        f_pfd = ref_clk/D
                        if(self.is_between(self.pfd_min, f_pfd, self.pfd_max)):
                            f_vco = ref_clk * M / D
                            stability_metric = self.__calc_stability_metric__(f_pfd, f_vco, O)
                            arr.append((M, D, O, n, f_vco, f_pfd, ref_clk, \
                                        out, out / (10 ** 6), delay, delay / (10 ** -12), \
                                        stability_metric))
                        
        df = pd.DataFrame(arr, columns = ["M", "D", "O", "n", "Fvco", "Fpfd", "Fref", \
                                          "Fout", "Fout (MHz)", "delay", "delay (ps)", \
                                          "stability metric"])
        
        df = df.sort_values(["delay", "Fvco"])
        df = df.reset_index()
        
        return df

    def optimize_pll_configs(self, df, delay_min_ps, delay_max_ps, \
                             res_ps=10, metric="stability"):
        step = int(res_ps/2)
        opt_df = pd.DataFrame(columns=df.columns.values.tolist())
        if(metric == "stability"):
            for delay in range (int(delay_min_ps), int(delay_max_ps-res_ps), res_ps):
                window_max = delay + res_ps
                window_min = delay
                if not df.empty:
                    # Get all candidate configurations
                    df_tmp = df[df["delay (ps)"] >= window_min]
                else:
                    continue
                if not df_tmp.empty:
                    df_tmp = df_tmp[df_tmp["delay (ps)"] < window_max]
                if not df_tmp.empty:
                    # Filter configurations with the highest stability metric
                    df_tmp = df_tmp[df_tmp["stability metric"] == df_tmp["stability metric"].max()]
                    opt_df = pd.concat([opt_df, df_tmp], axis=0)
                    
        opt_df = opt_df.reset_index()
        return opt_df

