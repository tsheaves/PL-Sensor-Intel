set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to "soc_system:u0|soc_system_theta_clks:theta_clks|altera_pll:altera_pll_i|altera_cyclonev_pll:cyclonev_pll|divclk[0]"
set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to "soc_system:u0|soc_system_theta_clks:theta_clks|altera_pll:altera_pll_i|altera_cyclonev_pll:cyclonev_pll|divclk[1]"
set_instance_assignment -name MATCH_PLL_COMPENSATION_CLOCK ON -to "soc_system:u0|soc_system_theta_clks:theta_clks|altera_pll:altera_pll_i|altera_cyclonev_pll:cyclonev_pll|divclk[1]"
