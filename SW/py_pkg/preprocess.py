from itertools import product
import pandas as pd
import numpy as np

def is_between(a, x, b):
    return min(a, b) <= x <= max(a, b)

def gen_pll_params( \
    vendor = 'intel', ref_clk  = 50 * 10 ** 6, out_min = 100 * 10 ** 6, out_max = 100 * 10 ** 6, \
    vco_max = 1600 * 10 ** 6, vco_min =  600 * 10 ** 6, \
    delay_lower = 1500 * 10 ** -12, delay_upper = 5000 * 10 ** -12, Ms=range(1, 512), Ds=range(1, 512), Os=range(1, 512)):

    # # Valid M values (Feedback Clock Divider).
    # Ms = range(2, 65) if vendor == 'xilinx' else range(1,512)

    # # Valid D values (Global Divider) -- Known as N on intel archs?
    # Ds = range(1, 107) if vendor == 'xilinx' else range(1,512)

    # # Valid O values (Output Clock Divider). -- Known as C on intel archs?
    # Os = range(1, 128) if vendor == 'xilinx' else range(1,512)

    vendor = vendor.lower()
    
    # Fine Grain Divider
    fgdiv = 56 if vendor == 'xilinx' else 8
    
    # Take the cross product and filter to keep all M/D values that produce valid Fvco frequencies
    vcos = [(M,D) for (M,D) in product(Ms, Ds) if is_between(vco_min, ref_clk * M / D, vco_max)]
    
    arr = []
    for (M, D) in vcos:
        for O in Os:
            # Compute the output frequency from the current parameters
            out = ref_clk * M/(D * O)
            if( (out > out_max) or (out < out_min) ):
                continue # Skip loop iteration
            for n in range (0, round(fgdiv * ref_clk * M / (D * out))):
                delay = round(D * O / (ref_clk * M) - n / (fgdiv * out * O), 15)
                if(is_between(delay_lower, delay, delay_upper)):
                    arr.append((M, D, O, n, ref_clk * M / D, ref_clk, out, out / (10 ** 6), delay, delay / (10 ** -12)))              
    df = pd.DataFrame(arr, columns = ["M", "D", "O", "n", "Fvco", "Fref", "Fout", "Fout (MHz)", "delay", "delay (ps)"])
    df["delay (ps)"] = list(np.around(np.array(df["delay (ps)"]),32))
    df = df.sort_values(["delay", "Fvco"]).drop_duplicates(subset = "delay", keep = "first")
    return df

if __name__ == '__main__':
    # Baseline parameters 100MHz fixed
    # out_min_in      = 100*10**6
    # out_max_in      = 100*10**6
    # delay_lower_in  = 1400*10**-12
    # delay_upper_in  = 3750*10**-12
    # Ms_in           = [64]
    # Ds_in           = [2]
    # Os_in           = [16]
    # df = gen_pll_params(out_min=out_min_in, out_max=out_max_in, delay_lower=delay_lower_in, delay_upper=delay_upper_in, Ms=Ms_in, Ds=Ds_in, Os=Os_in)
    # df.to_csv("baseline_100MHz_params.csv")

    # # Coarsegrained parameters 100MHz fixed
    # out_min_in      = 100*10**6
    # out_max_in      = 100*10**6
    # delay_lower_in  = 1400*10**-12
    # delay_upper_in  = 3750*10**-12
    # Ms_in           = range(2,65)
    # Ds_in           = range(1,107)
    # Os_in           = range(1,128)
    # df = gen_pll_params(out_min=out_min_in, out_max=out_max_in, delay_lower=delay_lower_in, delay_upper=delay_upper_in, Ms=Ms_in, Ds=Ds_in, Os=Os_in)
    # df.to_csv("coarsegrained_100MHz_params.csv")

    # Finegrained 100MHz fixed
    out_min_in      = 100*10**6
    out_max_in      = 100*10**6
    delay_lower_in  = 0*10**-12
    delay_upper_in  = 5000*10**-12
    Ms_in           = range(1,512)
    Ds_in           = range(1,512)
    Os_in           = range(1,512)
    
    df = gen_pll_params(ref_clk  = 10 * 10 ** 6, out_min=out_min_in, out_max=out_max_in, delay_lower=delay_lower_in, delay_upper=delay_upper_in, Ms=Ms_in, Ds=Ds_in, Os=Os_in)
    df.to_csv("../pll_configs/theta.csv")

    out_min_in      = 10*10**6
    out_max_in      = 10*10**6
    delay_lower_in  = 0*10**-12
    delay_upper_in  = 2*((1/out_min_in)*10**12)
    Ms_in           = range(1,512)
    Ds_in           = range(1,512)
    Os_in           = range(1,512)
    df = gen_pll_params(ref_clk  = 50 * 10 ** 6, out_min=out_min_in, out_max=out_max_in, delay_lower=delay_lower_in, delay_upper=delay_upper_in, Ms=Ms_in, Ds=Ds_in, Os=Os_in)
    df.to_csv("phi.csv")

    # Pentimenti Finegrained 50-100MHz 
    # out_min_in      = 90*10**6
    # out_max_in      = 100*10**6
    # delay_lower_in  = 1400*10**-12
    # delay_upper_in  = 3750*10**-12
    # Ms_in           = range(1,512)
    # Ds_in           = range(1,512)
    # Os_in           = range(1,512)
    # df = gen_pll_params(out_min=out_min_in, out_max=out_max_in, delay_lower=delay_lower_in, delay_upper=delay_upper_in, Ms=Ms_in, Ds=Ds_in, Os=Os_in)
    # df.to_csv("finegrained_90-100MHz_params.csv")
