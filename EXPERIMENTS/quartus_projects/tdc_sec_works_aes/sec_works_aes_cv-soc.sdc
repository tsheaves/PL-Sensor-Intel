#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period "50.0 MHz" [get_ports FPGA_CLK1_50]
create_clock -period "50.0 MHz" [get_ports FPGA_CLK2_50]
create_clock -period "50.0 MHz" [get_ports FPGA_CLK3_50]

# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck 3 [get_ports altera_reserved_tdo]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks

#**************************************************************
# Set Clock Latency
#**************************************************************

#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty -overwrite

# set_false_path -from [get_registers {u0|pulsegenerator|M_AVST_DATA[0]}] -to [get_registers {u0|tdc_0|carry0|carry_chain:cc|*}]
# set_max_skew -from {soc_system:u0|pulsegenerator:pulsegenerator|M_AVST_DATA_P[3][0]} -to [list {soc_system:u0|tdc_top:tdc_0|carry_top:carry0|carry_chain:cc|s[*]} {soc_system:u0|tdc_top:tdc_0|carry_top:carry0|carry_chain:cc|val_out}] 0.1
# set_min_delay -from [get_clocks {u0|theta_clks|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -to [get_clocks {u0|theta_clks|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] 0.000
# set_max_delay -from [get_clocks {u0|theta_clks|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -to [get_clocks {u0|theta_clks|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] 0.1
# set_max_skew -from_clock [get_clocks {u0|theta_clks|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -to_clock [get_clocks {u0|theta_clks|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] 0.1
#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************
