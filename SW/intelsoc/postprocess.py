import statistics
import matplotlib.pyplot as plt
import numpy as np
from numpy import diff
from numpy import corrcoef
import pandas as pd

def popcount(x):
    return bin(x).count('1')

# Trim all 0's/max_pop_count from pop_counts
#   Return all pop counts and pruned samples/pop_counts
def calc_pop_counts(falling_samples, rising_samples, bitwidth):
    pop_counts_rising = [] 
    pop_counts_falling = []
    for sample_rise, sample_fall in zip(rising_samples, falling_samples):        
        pop_counts_rising.append(popcount(sample_rise))
        pop_counts_falling.append(bitwidth-popcount(sample_fall))
    return pop_counts_rising, pop_counts_falling

def decode_samples(samples, max_val):
    '''
    Detect saturated samples (all 1's/all 0's)
        if all samples are saturated to 1 or 0
        return unknown offset
    '''
    return samples[0::4], samples[2::4]
    # Detect offset for all 1's/0's for all samples
    # len_subset = int(len(samples)/4)
    # done = 0
    # unknown = 1
    # for sample in samples:
    #     if(sample != max_val and sample != 0):
    #         unknown = 0
    #         break
    # if unknown == 0:
    #     for offset in range(4):
    #         offset_falling = (offset - 1) % 4
    #         falling = samples[offset_falling::4]
    #         offset_0s = offset
    #         all_0s = samples[offset::4]
    #         offset_rising = (offset + 1) % 4
    #         rising = samples[offset_rising::4]
    #         offset_1s = (offset + 2) % 4
    #         all_1s = samples[offset_1s::4]
    #         success = 1
    #         for samp_1, samp_0 in zip(all_1s, all_0s):
    #             if samp_1 != max_val or samp_0 != 0:
    #                 success = 0
    #                 break
    #         if success == 1:
    #             return falling, rising
    # else:
    #     if fill < 2:
    #         if fill:
    #             return [0]*len_subset, [max_val]*len_subset
    #         else:
    #             return [max_val]*len_subset, [0]*len_subset

    # return [-1]*len_subset, [-1]*len_subset


def pattern_check(pop_counts, start_pattern, start_idx, max_pop_count):
    if start_pattern == 0:
        all_0s = pop_counts[start_idx::4]
        all_1s = pop_counts[start_idx+2::4]
    else:
        all_1s = pop_counts[start_idx::4]
        all_0s = pop_counts[start_idx+2::4]

    for idx, sample in enumerate(all_0s):
        if sample != 0:
            print(f"Error: sample pattern not matched at idx {idx:04d}")
            return 1

    for idx, sample in enumerate(all_1s):
        if sample != max_pop_count:
            print(f"Error: sample pattern not matched at idx {idx:04d}")
            return 1

    return 0

def firsts_lasts(samples, pol, bitwidth):
    firsts = []
    lasts  = []
    for sample in samples:
        first = 0
        last  = bitwidth
        for idx in range(bitwidth):
            bv = sample >> idx
            if((bv & 1) == pol ^ 1):
                break
            first += 1
        firsts.append(first)
        for idx in range(bitwidth):
            bv = sample >> ( bitwidth - idx - 1 )
            if (bv & 1) == pol:
                break
            last -= 1
        lasts.append(last)
    return firsts, lasts

def calc_firsts_lasts(falling_samples, rising_samples, bitwidth):
    firsts_rising, lasts_rising = firsts_lasts(rising_samples, 1, bitwidth)
    firsts_falling, lasts_falling = firsts_lasts(falling_samples, 0, bitwidth)
    return firsts_rising, firsts_falling, lasts_rising, lasts_falling

# Determine if a sample sequence yielded aligned traces
def process_pop_counts(pop_counts_rising, pop_counts_falling):
    mean_rising_pop = np.mean(pop_counts_rising)
    mean_falling_pop = np.mean(pop_counts_falling)
    return mean_falling_pop, mean_rising_pop

# Determine if a sample sequence yielded aligned traces
def process_pop_counts_var(pop_counts_rising, pop_counts_falling):
    mean_rising_pop = np.mean(pop_counts_rising)
    mean_falling_pop = np.mean(pop_counts_falling)
    var_rising_pop = np.var(pop_counts_rising, ddof=0)
    var_falling_pop = np.var(pop_counts_falling, ddof=0)
    return mean_falling_pop, mean_rising_pop, var_falling_pop, var_rising_pop

def process_firsts_lasts(firsts_rising, firsts_falling, lasts_rising, lasts_falling):
    mean_firsts_rise = np.mean(firsts_rising)
    mean_firsts_fall = np.mean(firsts_falling)
    mean_lasts_rise = np.mean(lasts_rising)
    mean_lasts_fall = np.mean(lasts_falling)
    return mean_firsts_rise, mean_firsts_fall, mean_lasts_rise, mean_lasts_fall

# Plot the rising and falling hamming weights for a sample sequence
def plot_rising_falling_hws( \
    pop_counts_falling, mean_falling_pop,
    pop_counts_rising, mean_rising_pop,
    path, fout, delay):
    fig, ax = plt.subplots()
    x = range(len(pop_counts_falling))
    y1 = ax.plot(pop_counts_falling, label="Falling, " + r"$\mu$" + f"= {mean_falling_pop:.2f}", linewidth=0.4)
    y2 = ax.plot(pop_counts_rising,  label=" Rising, " + r"$\mu$" + f"= {mean_rising_pop:.2f}", linewidth=0.4)
    ax.legend()
    ax.set_title(f'Hamming Weight @{fout:.3f}MHz Sampling Rate w/ {delay:.4f}ps delay')
    ax.set_ylim([0, 256])
    ax.set_xlabel('Sample Number')
    ax.set_ylabel('Hamming Weight')
    fig.savefig(path, bbox_inches='tight', dpi=400)
    plt.close('all')

def plot_sweep_results_hw(sweep_dict, path):
    fig, (ax1, ax8, ax2, ax3, ax4, ax5, ax6, ax7, ax9) = plt.subplots(9, sharex=True, gridspec_kw={'height_ratios': [3, 1, 1, 1, 1, 1, 1, 1, 1]})
    x = range(len(sweep_dict['delay (ps)']))
    
    delta = [0]
    for idx, delay in enumerate(sweep_dict['delay (ps)'][1:], 1):
        delta.append(sweep_dict['delay (ps)'][idx]-sweep_dict['delay (ps)'][idx-1])

    diff1 = np.diff(sweep_dict['pop fall avg'])/np.diff(sweep_dict['delay (ps)'])
    diff1 = np.insert(diff1, 0, 0)
    diff2 = np.diff(sweep_dict['pop rise avg'])/np.diff(sweep_dict['delay (ps)'])
    diff2 = np.insert(diff2, 0, 0)
    y1 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['pop fall avg'], label=r"$\mu_{popcount_{falling}}$", linewidth=0.5)
    y2 = ax8.plot(sweep_dict['delay (ps)'], diff1, linestyle='dotted',label=r"$\frac{dx}{dt}\mu_{popcount_{falling}} $", linewidth=0.5)
    y3 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['pop rise avg'],  label=r"$\mu_{popcount_{rising}}$", linewidth=0.5)
    y4 = ax8.plot(sweep_dict['delay (ps)'], diff2,  label=r"$\frac{dx}{dt}\mu_{popcount_{rising}} $", linewidth=0.5)
    # y3 = ax2.scatter(sweep_dict['delay (ps)'], delta, marker='x', linewidth=0.03)
    y3 = ax2.scatter(sweep_dict['delay (ps)'], sweep_dict['fout (MHz)'], marker='x', linewidth=0.05)
    y4 = ax3.scatter(sweep_dict['delay (ps)'], sweep_dict['m'], marker='x', linewidth=0.05)
    y5 = ax4.scatter(sweep_dict['delay (ps)'], sweep_dict['n'], marker='x', linewidth=0.05)
    y6 = ax5.scatter(sweep_dict['delay (ps)'], sweep_dict['c'], marker='x', linewidth=0.05)
    y7 = ax6.scatter(sweep_dict['delay (ps)'], sweep_dict['lf'], marker='x', linewidth=0.05)
    y8 = ax7.scatter(sweep_dict['delay (ps)'], sweep_dict['cp'], marker='x', linewidth=0.05)
    y8 = ax9.scatter(sweep_dict['delay (ps)'], sweep_dict['pb'], marker='x', linewidth=0.05)
    
    ax1.legend(loc="upper left")
    ax8.legend(loc="upper left")

    ax1.set_title(f'Avg Hamming Weights vs. Capture Delay')
    ax1.set_ylim([0, 64])

    # ax2.set_yscale('log')
    # ax2.set_ylim([10**-15, 10**1])
    # ax2.set_xlabel('Delay (ps)')
    # ax2.set_ylabel(r'log($\Delta\theta (ps)$)')
    ax1.set_ylabel('Avg HW (1024 samples)')
    ax2.set_ylabel('Fout (MHz)')
    ax3.set_ylabel('m')
    ax4.set_ylabel('n')
    ax5.set_ylabel('c')
    ax6.set_ylabel('lf')
    ax7.set_ylabel('cp')
    ax8.set_ylabel(r"$\frac{dx}{dt}\mu_{popcounts}$")
    ax9.set_ylabel("pb")
    ax9.set_xlabel('Delay (ps)')

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{popcount_{falling}}, fout)$ = "+str(np.corrcoef(np.asarray(sweep_dict['fout (MHz)']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{popcount_{rising}}, fout)$ = "+str(np.corrcoef(np.asarray(sweep_dict['fout (MHz)']), diff2)[0, 1])])
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
    ax2.text(0.05, 0.95, textstr, transform=ax2.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{popcount_{falling}}, m)$ = "+str(np.corrcoef(np.asarray(sweep_dict['m']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{popcount_{rising}}, m)$ = "+str(np.corrcoef(np.asarray(sweep_dict['m']), diff2)[0, 1])])
    ax3.text(0.05, 0.95, textstr, transform=ax3.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{popcount_{falling}}, n)$ = "+str(np.corrcoef(np.asarray(sweep_dict['n']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{popcount_{rising}}, n)$ = "+str(np.corrcoef(np.asarray(sweep_dict['n']), diff2)[0, 1])])
    ax4.text(0.05, 0.95, textstr, transform=ax4.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{popcount_{falling}},c)$ = "+str(np.corrcoef(np.asarray(sweep_dict['c']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{popcount_{rising}},c)$ = "+str(np.corrcoef(np.asarray(sweep_dict['c']), diff2)[0, 1])])
    ax5.text(0.05, 0.95, textstr, transform=ax5.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{popcount_{falling}},lf)$ = "+str(np.corrcoef(np.asarray(sweep_dict['lf']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{popcount_{rising}},lf)$ = "+str(np.corrcoef(np.asarray(sweep_dict['lf']), diff2)[0, 1])])
    ax6.text(0.05, 0.95, textstr, transform=ax6.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{popcount_{falling}},cp)$ = "+str(np.corrcoef(np.asarray(sweep_dict['cp']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{popcount_{rising}},cp)$ = "+str(np.corrcoef(np.asarray(sweep_dict['cp']), diff2)[0, 1])])
    ax7.text(0.05, 0.95, textstr, transform=ax7.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)
    
    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{popcount_{falling}},pb)$ = "+str(np.corrcoef(np.asarray(sweep_dict['pb']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{popcount_{rising}},pb)$ = "+str(np.corrcoef(np.asarray(sweep_dict['pb']), diff2)[0, 1])])
    ax9.text(0.05, 0.95, textstr, transform=ax9.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    fig.set_size_inches(10, 10)
    plt.tight_layout()
    fig.savefig(path, bbox_inches='tight', dpi=300, pad_inches=0.1)
    plt.close('all')

def plot_sweep_results_first(sweep_dict, path):
    fig, (ax1, ax8, ax2, ax3, ax4, ax5, ax6, ax7, ax9) = plt.subplots(9, sharex=True, gridspec_kw={'height_ratios': [3, 1, 1, 1, 1, 1, 1, 1, 1]})

    diff1 = np.diff(sweep_dict['firsts rise avg'])/np.diff(sweep_dict['delay (ps)'])
    diff1 = np.insert(diff1, 0, 0)
    diff2 = np.diff(sweep_dict['firsts fall avg'])/np.diff(sweep_dict['delay (ps)'])
    diff2 = np.insert(diff2, 0, 0)

    y1 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['firsts fall avg'], label=r"$\mu_{firsts_{falling}}$", linewidth=0.5)
    y2 = ax8.plot(sweep_dict['delay (ps)'], diff1, linestyle='dotted',label=r"$\frac{dx}{dt}\mu_{firsts_{falling}} $", linewidth=0.5)
    y3 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['firsts rise avg'],  label=r"$\mu_{firsts_{rising}}$", linewidth=0.5)
    y4 = ax8.plot(sweep_dict['delay (ps)'], diff2,  label=r"$\frac{dx}{dt}\mu_{firsts_{rising}} $", linewidth=0.5)
    # y3 = ax2.scatter(sweep_dict['delay (ps)'], delta, marker='x', linewidth=0.03)
    y3 = ax2.scatter(sweep_dict['delay (ps)'], sweep_dict['fout (MHz)'], marker='x', linewidth=0.05)
    y4 = ax3.scatter(sweep_dict['delay (ps)'], sweep_dict['m'], marker='x', linewidth=0.05)
    y5 = ax4.scatter(sweep_dict['delay (ps)'], sweep_dict['n'], marker='x', linewidth=0.05)
    y6 = ax5.scatter(sweep_dict['delay (ps)'], sweep_dict['c'], marker='x', linewidth=0.05)
    y7 = ax6.scatter(sweep_dict['delay (ps)'], sweep_dict['lf'], marker='x', linewidth=0.05)
    y8 = ax7.scatter(sweep_dict['delay (ps)'], sweep_dict['cp'], marker='x', linewidth=0.05)
    y8 = ax9.scatter(sweep_dict['delay (ps)'], sweep_dict['pb'], marker='x', linewidth=0.05)
    
    ax1.legend(loc="upper left")
    ax8.legend(loc="upper left")

    ax1.set_title(f'Avg First Idx vs. Capture Delay')
    ax1.set_ylim([0, 64])

    # ax2.set_yscale('log')
    # ax2.set_ylim([10**-15, 10**1])
    # ax2.set_xlabel('Delay (ps)')
    # ax2.set_ylabel(r'log($\Delta\theta (ps)$)')
    ax1.set_ylabel('Avg HW (1024 samples)')
    ax2.set_ylabel('Fout (MHz)')
    ax3.set_ylabel('m')
    ax4.set_ylabel('n')
    ax5.set_ylabel('c')
    ax6.set_ylabel('lf')
    ax7.set_ylabel('cp')
    ax8.set_ylabel(r"$\frac{dx}{dt}\mu_{firsts}$")
    ax9.set_ylabel("pb")
    ax9.set_xlabel('Delay (ps)')

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{firsts_{falling}}, fout)$ = "+str(np.corrcoef(np.asarray(sweep_dict['fout (MHz)']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{firsts_{rising}}, fout)$ = "+str(np.corrcoef(np.asarray(sweep_dict['fout (MHz)']), diff2)[0, 1])])
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
    ax2.text(0.05, 0.95, textstr, transform=ax2.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{firsts_{falling}}, m)$ = "+str(np.corrcoef(np.asarray(sweep_dict['m']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{firsts_{rising}}, m)$ = "+str(np.corrcoef(np.asarray(sweep_dict['m']), diff2)[0, 1])])
    ax3.text(0.05, 0.95, textstr, transform=ax3.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{firsts_{falling}}, n)$ = "+str(np.corrcoef(np.asarray(sweep_dict['n']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{firsts_{rising}}, n)$ = "+str(np.corrcoef(np.asarray(sweep_dict['n']), diff2)[0, 1])])
    ax4.text(0.05, 0.95, textstr, transform=ax4.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{firsts_{falling}},c)$ = "+str(np.corrcoef(np.asarray(sweep_dict['c']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{firsts_{rising}},c)$ = "+str(np.corrcoef(np.asarray(sweep_dict['c']), diff2)[0, 1])])
    ax5.text(0.05, 0.95, textstr, transform=ax5.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{firsts_{falling}},lf)$ = "+str(np.corrcoef(np.asarray(sweep_dict['lf']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{firsts_{rising}},lf)$ = "+str(np.corrcoef(np.asarray(sweep_dict['lf']), diff2)[0, 1])])
    ax6.text(0.05, 0.95, textstr, transform=ax6.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{firsts_{falling}},cp)$ = "+str(np.corrcoef(np.asarray(sweep_dict['cp']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{firsts_{rising}},cp)$ = "+str(np.corrcoef(np.asarray(sweep_dict['cp']), diff2)[0, 1])])
    ax7.text(0.05, 0.95, textstr, transform=ax7.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)
    
    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{firsts_{falling}},pb)$ = "+str(np.corrcoef(np.asarray(sweep_dict['pb']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{firsts_{rising}},pb)$ = "+str(np.corrcoef(np.asarray(sweep_dict['pb']), diff2)[0, 1])])
    ax9.text(0.05, 0.95, textstr, transform=ax9.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    fig.set_size_inches(10, 10)
    plt.tight_layout()
    fig.savefig(path, bbox_inches='tight', dpi=300, pad_inches=0.1)
    plt.close('all')

def plot_sweep_results_last(sweep_dict, path):
    fig, (ax1, ax8, ax2, ax3, ax4, ax5, ax6, ax7, ax9) = plt.subplots(9, sharex=True, gridspec_kw={'height_ratios': [3, 1, 1, 1, 1, 1, 1, 1, 1]})
    x = range(len(sweep_dict['delay (ps)']))

    diff1 = np.diff(sweep_dict['lasts rise avg'])/np.diff(sweep_dict['delay (ps)'])
    diff1 = np.insert(diff1, 0, 0)
    diff2 = np.diff(sweep_dict['lasts fall avg'])/np.diff(sweep_dict['delay (ps)'])
    diff2 = np.insert(diff2, 0, 0)
    y1 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['lasts fall avg'], label=r"$\mu_{lasts_{falling}}$", linewidth=0.5)
    y2 = ax8.plot(sweep_dict['delay (ps)'], diff1, linestyle='dotted',label=r"$\frac{dx}{dt}\mu_{lasts_{falling}} $", linewidth=0.5)
    y3 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['lasts rise avg'],  label=r"$\mu_{lasts_{rising}}$", linewidth=0.5)
    y4 = ax8.plot(sweep_dict['delay (ps)'], diff2,  label=r"$\frac{dx}{dt}\mu_{lasts_{rising}} $", linewidth=0.5)
    # y3 = ax2.scatter(sweep_dict['delay (ps)'], delta, marker='x', linewidth=0.03)
    y3 = ax2.scatter(sweep_dict['delay (ps)'], sweep_dict['fout (MHz)'], marker='x', linewidth=0.05)
    y4 = ax3.scatter(sweep_dict['delay (ps)'], sweep_dict['m'], marker='x', linewidth=0.05)
    y5 = ax4.scatter(sweep_dict['delay (ps)'], sweep_dict['n'], marker='x', linewidth=0.05)
    y6 = ax5.scatter(sweep_dict['delay (ps)'], sweep_dict['c'], marker='x', linewidth=0.05)
    y7 = ax6.scatter(sweep_dict['delay (ps)'], sweep_dict['lf'], marker='x', linewidth=0.05)
    y8 = ax7.scatter(sweep_dict['delay (ps)'], sweep_dict['cp'], marker='x', linewidth=0.05)
    y8 = ax9.scatter(sweep_dict['delay (ps)'], sweep_dict['pb'], marker='x', linewidth=0.05)
    
    ax1.legend(loc="upper left")
    ax8.legend(loc="upper left")

    ax1.set_title(f'Avg Last Idx vs. Capture Delay')
    ax1.set_ylim([0, 64])

    # ax2.set_yscale('log')
    # ax2.set_ylim([10**-15, 10**1])
    # ax2.set_xlabel('Delay (ps)')
    # ax2.set_ylabel(r'log($\Delta\theta (ps)$)')
    ax1.set_ylabel('Avg HW (1024 samples)')
    ax2.set_ylabel('Fout (MHz)')
    ax3.set_ylabel('m')
    ax4.set_ylabel('n')
    ax5.set_ylabel('c')
    ax6.set_ylabel('lf')
    ax7.set_ylabel('cp')
    ax8.set_ylabel(r"$\frac{dx}{dt}\mu_{lasts}$")
    ax9.set_ylabel("pb")
    ax9.set_xlabel('Delay (ps)')

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{lasts_{falling}}, fout)$ = "+str(np.corrcoef(np.asarray(sweep_dict['fout (MHz)']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{lasts_{rising}}, fout)$ = "+str(np.corrcoef(np.asarray(sweep_dict['fout (MHz)']), diff2)[0, 1])])
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
    ax2.text(0.05, 0.95, textstr, transform=ax2.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{lasts_{falling}}, m)$ = "+str(np.corrcoef(np.asarray(sweep_dict['m']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{lasts_{rising}}, m)$ = "+str(np.corrcoef(np.asarray(sweep_dict['m']), diff2)[0, 1])])
    ax3.text(0.05, 0.95, textstr, transform=ax3.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{lasts_{falling}}, n)$ = "+str(np.corrcoef(np.asarray(sweep_dict['n']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{lasts_{rising}}, n)$ = "+str(np.corrcoef(np.asarray(sweep_dict['n']), diff2)[0, 1])])
    ax4.text(0.05, 0.95, textstr, transform=ax4.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{lasts_{falling}},c)$ = "+str(np.corrcoef(np.asarray(sweep_dict['c']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{lasts_{rising}},c)$ = "+str(np.corrcoef(np.asarray(sweep_dict['c']), diff2)[0, 1])])
    ax5.text(0.05, 0.95, textstr, transform=ax5.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{lasts_{falling}},lf)$ = "+str(np.corrcoef(np.asarray(sweep_dict['lf']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{lasts_{rising}},lf)$ = "+str(np.corrcoef(np.asarray(sweep_dict['lf']), diff2)[0, 1])])
    ax6.text(0.05, 0.95, textstr, transform=ax6.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{lasts_{falling}},cp)$ = "+str(np.corrcoef(np.asarray(sweep_dict['cp']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{lasts_{rising}},cp)$ = "+str(np.corrcoef(np.asarray(sweep_dict['cp']), diff2)[0, 1])])
    ax7.text(0.05, 0.95, textstr, transform=ax7.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)
    
    textstr = '\n'.join( \
        [r"$\rho(\frac{dx}{dt}\mu_{lasts_{falling}},pb)$ = "+str(np.corrcoef(np.asarray(sweep_dict['pb']), diff1)[0, 1]), \
         r"$\rho(\frac{dx}{dt}\mu_{lasts_{rising}},pb)$ = "+str(np.corrcoef(np.asarray(sweep_dict['pb']), diff2)[0, 1])])
    ax9.text(0.05, 0.95, textstr, transform=ax9.transAxes, fontsize=6,
            verticalalignment='top', bbox=props)

    fig.set_size_inches(10, 10)
    plt.tight_layout()
    fig.savefig(path, bbox_inches='tight', dpi=300, pad_inches=0.1)
    plt.close('all')

def plot_sweep_results_alls(sweep_dict, path):
    fig, (ax1, ax2) = plt.subplots(2, sharex=False)
    dxs = []
    for idx, dx in enumerate(sweep_dict['delay (ps)'][1::], 1):
        dxs.append(dx - sweep_dict['delay (ps)'][idx - 1])
    y1 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['lasts fall avg'], label=r"$\mu_{lasts_{falling}}$", linewidth=0.5)
    y2 = ax2.plot(sweep_dict['delay (ps)'], sweep_dict['lasts rise avg'],  label=r"$\mu_{lasts_{rising}}$", linewidth=0.5)
    y3 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['firsts fall avg'], label=r"$\mu_{firsts_{falling}}$", linewidth=0.5)
    y4 = ax2.plot(sweep_dict['delay (ps)'], sweep_dict['firsts rise avg'],  label=r"$\mu_{firsts_{rising}}$", linewidth=0.5)
    y5 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['pop fall avg'], label=r"$\mu_{popcount_{falling}}$", linewidth=0.5)
    y6 = ax2.plot(sweep_dict['delay (ps)'], sweep_dict['pop rise avg'],  label=r"$\mu_{popcount_{rising}}$", linewidth=0.5)
    
    # binwidth_delta = 0.00001
    # binwidth_delay = 5
    # y7 = ax3.hist(sweep_dict['delay (ps)'], edgecolor='black', bins=np.arange(min(sweep_dict['delay (ps)']), max(sweep_dict['delay (ps)']) + binwidth_delay, binwidth_delay))
    # y8 = ax4.hist(dxs, edgecolor='black', bins=np.arange(min(dxs), max(dxs) + binwidth_delta, binwidth_delta))

    ax1.legend(loc="upper left")
    ax2.legend(loc="upper left")

    ax1.set_title(f'Avg of 1024 Measurements vs. Theta')
    ax1.set_ylim([-2, 258])
    ax2.set_ylim([-2, 258])

    min_delay = min(sweep_dict['delay (ps)'])
    max_delay = max(sweep_dict['delay (ps)'])
    ax1.set_xlim([min_delay, max_delay])
    ax2.set_xlim([min_delay, max_delay])
    # ax3.set_xlim([min_delay, max_delay])

    # ax2.set_yscale('log')
    # ax2.set_ylim([10**-15, 10**1])
    # ax2.set_xlabel('Delay (ps)')
    # ax2.set_ylabel(r'log($\Delta\theta (ps)$)')
    ax1.set_ylabel('Avg Propagation Falling')
    ax2.set_ylabel('Avg Propagation Rising')
    # ax3.set_ylabel('Count')
    ax2.set_xlabel('Theta (ps)')
    # ax4.set_ylabel('Count')
    # ax4.set_xlabel(r'$\Delta$Theta (ps)')

    fig.set_size_inches(10, 9)
    plt.tight_layout()
    fig.savefig(path, bbox_inches='tight', dpi=500, pad_inches=0.1)
    plt.close('all')
    
def plot_sweep_results_alls(sweep_dict, path):
    fig, (ax1, ax2) = plt.subplots(2, sharex=False)
    dxs = []
    for idx, dx in enumerate(sweep_dict['delay (ps)'][1::], 1):
        dxs.append(dx - sweep_dict['delay (ps)'][idx - 1])
    y1 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['lasts fall avg'], label=r"$\mu_{lasts_{falling}}$", linewidth=0.5)
    y2 = ax2.plot(sweep_dict['delay (ps)'], sweep_dict['lasts rise avg'],  label=r"$\mu_{lasts_{rising}}$", linewidth=0.5)
    y3 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['firsts fall avg'], label=r"$\mu_{firsts_{falling}}$", linewidth=0.5)
    y4 = ax2.plot(sweep_dict['delay (ps)'], sweep_dict['firsts rise avg'],  label=r"$\mu_{firsts_{rising}}$", linewidth=0.5)
    y5 = ax1.plot(sweep_dict['delay (ps)'], sweep_dict['pop fall avg'], label=r"$\mu_{popcount_{falling}}$", linewidth=0.5)
    y6 = ax2.plot(sweep_dict['delay (ps)'], sweep_dict['pop rise avg'],  label=r"$\mu_{popcount_{rising}}$", linewidth=0.5)
    
    # binwidth_delta = 0.00001
    # binwidth_delay = 5
    # y7 = ax3.hist(sweep_dict['delay (ps)'], edgecolor='black', bins=np.arange(min(sweep_dict['delay (ps)']), max(sweep_dict['delay (ps)']) + binwidth_delay, binwidth_delay))
    # y8 = ax4.hist(dxs, edgecolor='black', bins=np.arange(min(dxs), max(dxs) + binwidth_delta, binwidth_delta))

    ax1.legend(loc="upper left")
    ax2.legend(loc="upper left")

    ax1.set_title(f'Avg of 1024 Measurements vs. Theta')
    ax1.set_ylim([-2, 258])
    ax2.set_ylim([-2, 258])

    min_delay = min(sweep_dict['delay (ps)'])
    max_delay = max(sweep_dict['delay (ps)'])
    ax1.set_xlim([min_delay, max_delay])
    ax2.set_xlim([min_delay, max_delay])
    # ax3.set_xlim([min_delay, max_delay])

    # ax2.set_yscale('log')
    # ax2.set_ylim([10**-15, 10**1])
    # ax2.set_xlabel('Delay (ps)')
    # ax2.set_ylabel(r'log($\Delta\theta (ps)$)')
    ax1.set_ylabel('Avg Propagation Falling')
    ax2.set_ylabel('Avg Propagation Rising')
    # ax3.set_ylabel('Count')
    ax2.set_xlabel('Theta (ps)')
    # ax4.set_ylabel('Count')
    # ax4.set_xlabel(r'$\Delta$Theta (ps)')

    fig.set_size_inches(10, 9)
    plt.tight_layout()
    fig.savefig(path, bbox_inches='tight', dpi=500, pad_inches=0.1)
    plt.close('all')

def plot_sweep_results_alls_compare(base_dict, fine_dict, ta_dict, out_path, fout, delay_delta_bin_width):
    fig, (ax1, ax2, ax3, ax4) = plt.subplots(4, sharex=False)

    # Plot fine dict TDC averages
    y1 = ax1.plot(fine_dict['delay (ps)'], fine_dict['lasts fall avg'], label=r"Fine-grain $\mu_{lasts}$", linewidth=0.5)
    # y13 = ax1.plot(ta_dict['fast_warm'], ta_dict['cc_element'], label="Timing Analyzer Estimation", linewidth=0.5)
    y2 = ax2.plot(fine_dict['delay (ps)'], fine_dict['lasts rise avg'],  label=r"Fine-grain $\mu_{lasts}$", linewidth=0.5)
    y3 = ax1.plot(fine_dict['delay (ps)'], fine_dict['firsts fall avg'], label=r"Fine-grain $\mu_{firsts}$", linewidth=0.5)
    y4 = ax2.plot(fine_dict['delay (ps)'], fine_dict['firsts rise avg'],  label=r"Fine-grain $\mu_{firsts}$", linewidth=0.5)
    y5 = ax1.plot(fine_dict['delay (ps)'], fine_dict['pop fall avg'], label=r"Fine-grain $\mu_{popcount}$", linewidth=0.5)
    y6 = ax2.plot(fine_dict['delay (ps)'], fine_dict['pop rise avg'],  label=r"Fine-grain $\mu_{popcount}$", linewidth=0.5)
    # y14 = ax2.plot(ta_dict['fast_warm'], ta_dict['cc_element'], label="Timing Analyzer Estimation", linewidth=0.5)

    # Plot baseline dict TDC averages
    y7 = ax1.scatter(base_dict['delay (ps)'], base_dict['lasts fall avg'], marker = 'o', label=r"Nominal $\mu_{lasts}$", linewidth=0.5, alpha=0.5)
    y8 = ax2.scatter(base_dict['delay (ps)'], base_dict['lasts rise avg'], marker = 'o',  label=r"Nominal $\mu_{lasts}$", linewidth=0.5, alpha=0.5)
    y9 = ax1.scatter(base_dict['delay (ps)'], base_dict['firsts fall avg'], marker = 'o', label=r"Nominal $\mu_{firsts}$", linewidth=0.5, alpha=0.5)
    y10 = ax2.scatter(base_dict['delay (ps)'], base_dict['firsts rise avg'], marker = 'o',  label=r"Nominal $\mu_{firsts}$", linewidth=0.5, alpha=0.5)
    y11 = ax1.scatter(base_dict['delay (ps)'], base_dict['pop fall avg'], marker = 'o', label=r"Nominal $\mu_{popcount}$", linewidth=0.5, alpha=0.5)
    y12 = ax2.scatter(base_dict['delay (ps)'], base_dict['pop rise avg'], marker = 'o',  label=r"Nominal $\mu_{popcount}$", linewidth=0.5, alpha=0.5)

    dxs_base = []
    dxs_fine = []

    for idx, dx in enumerate(base_dict['delay (ps)'][1::], 1):
        dxs_base.append(dx - base_dict['delay (ps)'][idx - 1])

    for idx, dx in enumerate(fine_dict['delay (ps)'][1::], 1):
        dxs_fine.append(dx - fine_dict['delay (ps)'][idx - 1])

    binwidth_delta = delay_delta_bin_width
    binwidth_delay = 1
    y13 = ax3.hist(fine_dict['delay (ps)'], bins=np.arange(min(fine_dict['delay (ps)']), max(fine_dict['delay (ps)']) + binwidth_delay, binwidth_delay), alpha=0.75, label='Fine-grain')
    y14 = ax3.hist(base_dict['delay (ps)'], bins=np.arange(min(base_dict['delay (ps)']), max(base_dict['delay (ps)']) + binwidth_delay, binwidth_delay), alpha=0.75, label='Nominal')
    y15 = ax4.hist(dxs_fine, bins=np.arange(min(dxs_fine), max(dxs_fine) + binwidth_delta, binwidth_delta), alpha=0.75, label=r'Fine-grain, $\mu=$'+ str(round(statistics.mean(dxs_fine), 3)) )
    y15 = ax4.hist(dxs_base, bins=np.arange(min(dxs_base), max(dxs_base) + binwidth_delta, binwidth_delta), alpha=0.75, label=r'Nominal, $\mu=$'+ str(round(statistics.mean(dxs_base), 3)) )

    ax1.legend(loc="upper left", ncol=2)
    ax2.legend(loc="upper left", ncol=2)
    ax3.legend(loc="upper left")
    ax4.legend(loc="upper left")

    ax1.set_title(r'Avg of 1024 Measurements vs. $\theta$ at $F_{out}=$' + fout)
    ax1.set_ylim([-2, 270])
    ax2.set_ylim([-2, 270])

    min_delay = min(fine_dict['delay (ps)'])
    max_delay = max(fine_dict['delay (ps)'])

    pad = 0.1
    min_delta_delay = min(dxs_fine) * (1-pad)
    max_delta_delay = max(dxs_fine) * (1+pad)

    ax1.set_xlim([min_delay, max_delay])
    ax2.set_xlim([min_delay, max_delay])
    ax3.set_xlim([min_delay, max_delay])
    ax4.set_xlim([min_delta_delay, max_delta_delay])

    ax1.set_ylabel('Avg Propagation Falling')
    ax2.set_ylabel('Avg Propagation Rising')
    ax3.set_ylabel('Count')
    ax3.set_xlabel(r'$\theta$ (ps)')
    ax4.set_ylabel('Count')
    ax4.set_xlabel(r'log($\Delta\theta$) (ps)')
    ax4.set_xscale('log')

    fig.set_size_inches(10, 9)
    plt.tight_layout()
    fig.savefig(out_path, bbox_inches='tight', dpi=500, pad_inches=0.1)
    plt.close('all')

def process_sample_avg_csv(delay_min, delay_max, ta_fh, base_fh, fine_fh, out_path, fout, delay_delta_bin_width=0.1):
    df_base = pd.read_csv(base_fh)
    df_base = df_base.drop(df_base[(df_base['delay (ps)'] < delay_min) | (df_base['delay (ps)'] > delay_max)].index)
    df_fine = pd.read_csv(fine_fh)
    df_fine = df_fine.drop(df_fine[(df_fine['delay (ps)'] < delay_min) | (df_fine['delay (ps)'] > delay_max)].index)
    df_ta   = pd.read_csv(ta_fh)
    ta_dict   = df_ta.to_dict(orient='list')
    base_dict = df_base.to_dict(orient='list')
    fine_dict = df_fine.to_dict(orient='list')
    # plot_sweep_results_hws(sweep_plot_data, "./avg_hw_plots.png")
    # plot_sweep_results_firsts(sweep_plot_data, "./avg_hw_plots.png")
    # plot_sweep_results_lasts(sweep_plot_data, "./avg_hw_plots.png")
    plot_sweep_results_alls_compare(base_dict, fine_dict, ta_dict, out_path, fout, delay_delta_bin_width)
    return 0

if __name__ == '__main__':
    base            = "./sweep_data_baseline_100MHz.csv"    
    fine            = "./sweep_data_finegrained_100MHz.csv"
    ta              = "./timing_analyzer_tdc_delays.csv"
    fout            = "100MHz"
    process_sample_avg_csv(0, 5000, ta, base, fine, "avg_alls_compare.png", fout, 0.1)
    fine_freq_sweep = "./sweep_data_finegrained_90-100MHz.csv"
    fout            = "90-100MHz"
    process_sample_avg_csv(0, 5000, ta, base, fine_freq_sweep, "avg_alls_compare_big.png", fout, 0.001)
