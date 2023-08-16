#============================================================
# Cascade PLL
#============================================================
set_location_assignment FRACTIONALPLL_X0_Y15_N0 -to "soc_system:u0|soc_system_phi_clk:phi_clk|altera_pll:altera_pll_i|altera_cyclonev_pll:cyclonev_pll|altera_cyclonev_pll_base:fpll_0|fpll"
set_location_assignment FRACTIONALPLL_X0_Y32_N0 -to "soc_system:u0|soc_system_theta_clks:theta_clks|altera_pll:altera_pll_i|altera_cyclonev_pll:cyclonev_pll|altera_cyclonev_pll_base:fpll_0|fpll"

#============================================================
# TDC
#============================================================
set_global_assignment -name STRATIXII_CARRY_CHAIN_LENGTH 257
set_location_assignment LABCELL_X35_Y29_N0 -to u0|tdc_0|carry0|cc|lcell_0
set_location_assignment FF_X35_Y29_N1 -to u0|tdc_0|carry0|cc|gen_reg_cc[1].reg_i
set_location_assignment LABCELL_X35_Y29_N3 -to u0|tdc_0|carry0|cc|gen_reg_cc[1].lcell_i
set_location_assignment FF_X35_Y29_N4 -to u0|tdc_0|carry0|cc|gen_reg_cc[2].reg_i
set_location_assignment LABCELL_X35_Y29_N6 -to u0|tdc_0|carry0|cc|gen_reg_cc[2].lcell_i
set_location_assignment FF_X35_Y29_N7 -to u0|tdc_0|carry0|cc|gen_reg_cc[3].reg_i
set_location_assignment LABCELL_X35_Y29_N9 -to u0|tdc_0|carry0|cc|gen_reg_cc[3].lcell_i
set_location_assignment FF_X35_Y29_N10 -to u0|tdc_0|carry0|cc|gen_reg_cc[4].reg_i
set_location_assignment LABCELL_X35_Y29_N12 -to u0|tdc_0|carry0|cc|gen_reg_cc[4].lcell_i
set_location_assignment FF_X35_Y29_N13 -to u0|tdc_0|carry0|cc|gen_reg_cc[5].reg_i
set_location_assignment LABCELL_X35_Y29_N15 -to u0|tdc_0|carry0|cc|gen_reg_cc[5].lcell_i
set_location_assignment FF_X35_Y29_N16 -to u0|tdc_0|carry0|cc|gen_reg_cc[6].reg_i
set_location_assignment LABCELL_X35_Y29_N18 -to u0|tdc_0|carry0|cc|gen_reg_cc[6].lcell_i
set_location_assignment FF_X35_Y29_N19 -to u0|tdc_0|carry0|cc|gen_reg_cc[7].reg_i
set_location_assignment LABCELL_X35_Y29_N21 -to u0|tdc_0|carry0|cc|gen_reg_cc[7].lcell_i
set_location_assignment FF_X35_Y29_N22 -to u0|tdc_0|carry0|cc|gen_reg_cc[8].reg_i
set_location_assignment LABCELL_X35_Y29_N24 -to u0|tdc_0|carry0|cc|gen_reg_cc[8].lcell_i
set_location_assignment FF_X35_Y29_N25 -to u0|tdc_0|carry0|cc|gen_reg_cc[9].reg_i
set_location_assignment LABCELL_X35_Y29_N27 -to u0|tdc_0|carry0|cc|gen_reg_cc[9].lcell_i
set_location_assignment FF_X35_Y29_N28 -to u0|tdc_0|carry0|cc|gen_reg_cc[10].reg_i
set_location_assignment LABCELL_X35_Y29_N30 -to u0|tdc_0|carry0|cc|gen_reg_cc[10].lcell_i
set_location_assignment FF_X35_Y29_N31 -to u0|tdc_0|carry0|cc|gen_reg_cc[11].reg_i
set_location_assignment LABCELL_X35_Y29_N33 -to u0|tdc_0|carry0|cc|gen_reg_cc[11].lcell_i
set_location_assignment FF_X35_Y29_N34 -to u0|tdc_0|carry0|cc|gen_reg_cc[12].reg_i
set_location_assignment LABCELL_X35_Y29_N36 -to u0|tdc_0|carry0|cc|gen_reg_cc[12].lcell_i
set_location_assignment FF_X35_Y29_N37 -to u0|tdc_0|carry0|cc|gen_reg_cc[13].reg_i
set_location_assignment LABCELL_X35_Y29_N39 -to u0|tdc_0|carry0|cc|gen_reg_cc[13].lcell_i
set_location_assignment FF_X35_Y29_N40 -to u0|tdc_0|carry0|cc|gen_reg_cc[14].reg_i
set_location_assignment LABCELL_X35_Y29_N42 -to u0|tdc_0|carry0|cc|gen_reg_cc[14].lcell_i
set_location_assignment FF_X35_Y29_N43 -to u0|tdc_0|carry0|cc|gen_reg_cc[15].reg_i
set_location_assignment LABCELL_X35_Y29_N45 -to u0|tdc_0|carry0|cc|gen_reg_cc[15].lcell_i
set_location_assignment FF_X35_Y29_N46 -to u0|tdc_0|carry0|cc|gen_reg_cc[16].reg_i
set_location_assignment LABCELL_X35_Y29_N48 -to u0|tdc_0|carry0|cc|gen_reg_cc[16].lcell_i
set_location_assignment FF_X35_Y29_N49 -to u0|tdc_0|carry0|cc|gen_reg_cc[17].reg_i
set_location_assignment LABCELL_X35_Y29_N51 -to u0|tdc_0|carry0|cc|gen_reg_cc[17].lcell_i
set_location_assignment FF_X35_Y29_N52 -to u0|tdc_0|carry0|cc|gen_reg_cc[18].reg_i
set_location_assignment LABCELL_X35_Y29_N54 -to u0|tdc_0|carry0|cc|gen_reg_cc[18].lcell_i
set_location_assignment FF_X35_Y29_N55 -to u0|tdc_0|carry0|cc|gen_reg_cc[19].reg_i
set_location_assignment LABCELL_X35_Y29_N57 -to u0|tdc_0|carry0|cc|gen_reg_cc[19].lcell_i
set_location_assignment FF_X35_Y29_N58 -to u0|tdc_0|carry0|cc|gen_reg_cc[20].reg_i
set_location_assignment LABCELL_X35_Y28_N0 -to u0|tdc_0|carry0|cc|gen_reg_cc[20].lcell_i
set_location_assignment FF_X35_Y28_N1 -to u0|tdc_0|carry0|cc|gen_reg_cc[21].reg_i
set_location_assignment LABCELL_X35_Y28_N3 -to u0|tdc_0|carry0|cc|gen_reg_cc[21].lcell_i
set_location_assignment FF_X35_Y28_N4 -to u0|tdc_0|carry0|cc|gen_reg_cc[22].reg_i
set_location_assignment LABCELL_X35_Y28_N6 -to u0|tdc_0|carry0|cc|gen_reg_cc[22].lcell_i
set_location_assignment FF_X35_Y28_N7 -to u0|tdc_0|carry0|cc|gen_reg_cc[23].reg_i
set_location_assignment LABCELL_X35_Y28_N9 -to u0|tdc_0|carry0|cc|gen_reg_cc[23].lcell_i
set_location_assignment FF_X35_Y28_N10 -to u0|tdc_0|carry0|cc|gen_reg_cc[24].reg_i
set_location_assignment LABCELL_X35_Y28_N12 -to u0|tdc_0|carry0|cc|gen_reg_cc[24].lcell_i
set_location_assignment FF_X35_Y28_N13 -to u0|tdc_0|carry0|cc|gen_reg_cc[25].reg_i
set_location_assignment LABCELL_X35_Y28_N15 -to u0|tdc_0|carry0|cc|gen_reg_cc[25].lcell_i
set_location_assignment FF_X35_Y28_N16 -to u0|tdc_0|carry0|cc|gen_reg_cc[26].reg_i
set_location_assignment LABCELL_X35_Y28_N18 -to u0|tdc_0|carry0|cc|gen_reg_cc[26].lcell_i
set_location_assignment FF_X35_Y28_N19 -to u0|tdc_0|carry0|cc|gen_reg_cc[27].reg_i
set_location_assignment LABCELL_X35_Y28_N21 -to u0|tdc_0|carry0|cc|gen_reg_cc[27].lcell_i
set_location_assignment FF_X35_Y28_N22 -to u0|tdc_0|carry0|cc|gen_reg_cc[28].reg_i
set_location_assignment LABCELL_X35_Y28_N24 -to u0|tdc_0|carry0|cc|gen_reg_cc[28].lcell_i
set_location_assignment FF_X35_Y28_N25 -to u0|tdc_0|carry0|cc|gen_reg_cc[29].reg_i
set_location_assignment LABCELL_X35_Y28_N27 -to u0|tdc_0|carry0|cc|gen_reg_cc[29].lcell_i
set_location_assignment FF_X35_Y28_N28 -to u0|tdc_0|carry0|cc|gen_reg_cc[30].reg_i
set_location_assignment LABCELL_X35_Y28_N30 -to u0|tdc_0|carry0|cc|gen_reg_cc[30].lcell_i
set_location_assignment FF_X35_Y28_N31 -to u0|tdc_0|carry0|cc|gen_reg_cc[31].reg_i
set_location_assignment LABCELL_X35_Y28_N33 -to u0|tdc_0|carry0|cc|gen_reg_cc[31].lcell_i
set_location_assignment FF_X35_Y28_N34 -to u0|tdc_0|carry0|cc|gen_reg_cc[32].reg_i
set_location_assignment LABCELL_X35_Y28_N36 -to u0|tdc_0|carry0|cc|gen_reg_cc[32].lcell_i
set_location_assignment FF_X35_Y28_N37 -to u0|tdc_0|carry0|cc|gen_reg_cc[33].reg_i
set_location_assignment LABCELL_X35_Y28_N39 -to u0|tdc_0|carry0|cc|gen_reg_cc[33].lcell_i
set_location_assignment FF_X35_Y28_N40 -to u0|tdc_0|carry0|cc|gen_reg_cc[34].reg_i
set_location_assignment LABCELL_X35_Y28_N42 -to u0|tdc_0|carry0|cc|gen_reg_cc[34].lcell_i
set_location_assignment FF_X35_Y28_N43 -to u0|tdc_0|carry0|cc|gen_reg_cc[35].reg_i
set_location_assignment LABCELL_X35_Y28_N45 -to u0|tdc_0|carry0|cc|gen_reg_cc[35].lcell_i
set_location_assignment FF_X35_Y28_N46 -to u0|tdc_0|carry0|cc|gen_reg_cc[36].reg_i
set_location_assignment LABCELL_X35_Y28_N48 -to u0|tdc_0|carry0|cc|gen_reg_cc[36].lcell_i
set_location_assignment FF_X35_Y28_N49 -to u0|tdc_0|carry0|cc|gen_reg_cc[37].reg_i
set_location_assignment LABCELL_X35_Y28_N51 -to u0|tdc_0|carry0|cc|gen_reg_cc[37].lcell_i
set_location_assignment FF_X35_Y28_N52 -to u0|tdc_0|carry0|cc|gen_reg_cc[38].reg_i
set_location_assignment LABCELL_X35_Y28_N54 -to u0|tdc_0|carry0|cc|gen_reg_cc[38].lcell_i
set_location_assignment FF_X35_Y28_N55 -to u0|tdc_0|carry0|cc|gen_reg_cc[39].reg_i
set_location_assignment LABCELL_X35_Y28_N57 -to u0|tdc_0|carry0|cc|gen_reg_cc[39].lcell_i
set_location_assignment FF_X35_Y28_N58 -to u0|tdc_0|carry0|cc|gen_reg_cc[40].reg_i
set_location_assignment LABCELL_X35_Y27_N0 -to u0|tdc_0|carry0|cc|gen_reg_cc[40].lcell_i
set_location_assignment FF_X35_Y27_N1 -to u0|tdc_0|carry0|cc|gen_reg_cc[41].reg_i
set_location_assignment LABCELL_X35_Y27_N3 -to u0|tdc_0|carry0|cc|gen_reg_cc[41].lcell_i
set_location_assignment FF_X35_Y27_N4 -to u0|tdc_0|carry0|cc|gen_reg_cc[42].reg_i
set_location_assignment LABCELL_X35_Y27_N6 -to u0|tdc_0|carry0|cc|gen_reg_cc[42].lcell_i
set_location_assignment FF_X35_Y27_N7 -to u0|tdc_0|carry0|cc|gen_reg_cc[43].reg_i
set_location_assignment LABCELL_X35_Y27_N9 -to u0|tdc_0|carry0|cc|gen_reg_cc[43].lcell_i
set_location_assignment FF_X35_Y27_N10 -to u0|tdc_0|carry0|cc|gen_reg_cc[44].reg_i
set_location_assignment LABCELL_X35_Y27_N12 -to u0|tdc_0|carry0|cc|gen_reg_cc[44].lcell_i
set_location_assignment FF_X35_Y27_N13 -to u0|tdc_0|carry0|cc|gen_reg_cc[45].reg_i
set_location_assignment LABCELL_X35_Y27_N15 -to u0|tdc_0|carry0|cc|gen_reg_cc[45].lcell_i
set_location_assignment FF_X35_Y27_N16 -to u0|tdc_0|carry0|cc|gen_reg_cc[46].reg_i
set_location_assignment LABCELL_X35_Y27_N18 -to u0|tdc_0|carry0|cc|gen_reg_cc[46].lcell_i
set_location_assignment FF_X35_Y27_N19 -to u0|tdc_0|carry0|cc|gen_reg_cc[47].reg_i
set_location_assignment LABCELL_X35_Y27_N21 -to u0|tdc_0|carry0|cc|gen_reg_cc[47].lcell_i
set_location_assignment FF_X35_Y27_N22 -to u0|tdc_0|carry0|cc|gen_reg_cc[48].reg_i
set_location_assignment LABCELL_X35_Y27_N24 -to u0|tdc_0|carry0|cc|gen_reg_cc[48].lcell_i
set_location_assignment FF_X35_Y27_N25 -to u0|tdc_0|carry0|cc|gen_reg_cc[49].reg_i
set_location_assignment LABCELL_X35_Y27_N27 -to u0|tdc_0|carry0|cc|gen_reg_cc[49].lcell_i
set_location_assignment FF_X35_Y27_N28 -to u0|tdc_0|carry0|cc|gen_reg_cc[50].reg_i
set_location_assignment LABCELL_X35_Y27_N30 -to u0|tdc_0|carry0|cc|gen_reg_cc[50].lcell_i
set_location_assignment FF_X35_Y27_N31 -to u0|tdc_0|carry0|cc|gen_reg_cc[51].reg_i
set_location_assignment LABCELL_X35_Y27_N33 -to u0|tdc_0|carry0|cc|gen_reg_cc[51].lcell_i
set_location_assignment FF_X35_Y27_N34 -to u0|tdc_0|carry0|cc|gen_reg_cc[52].reg_i
set_location_assignment LABCELL_X35_Y27_N36 -to u0|tdc_0|carry0|cc|gen_reg_cc[52].lcell_i
set_location_assignment FF_X35_Y27_N37 -to u0|tdc_0|carry0|cc|gen_reg_cc[53].reg_i
set_location_assignment LABCELL_X35_Y27_N39 -to u0|tdc_0|carry0|cc|gen_reg_cc[53].lcell_i
set_location_assignment FF_X35_Y27_N40 -to u0|tdc_0|carry0|cc|gen_reg_cc[54].reg_i
set_location_assignment LABCELL_X35_Y27_N42 -to u0|tdc_0|carry0|cc|gen_reg_cc[54].lcell_i
set_location_assignment FF_X35_Y27_N43 -to u0|tdc_0|carry0|cc|gen_reg_cc[55].reg_i
set_location_assignment LABCELL_X35_Y27_N45 -to u0|tdc_0|carry0|cc|gen_reg_cc[55].lcell_i
set_location_assignment FF_X35_Y27_N46 -to u0|tdc_0|carry0|cc|gen_reg_cc[56].reg_i
set_location_assignment LABCELL_X35_Y27_N48 -to u0|tdc_0|carry0|cc|gen_reg_cc[56].lcell_i
set_location_assignment FF_X35_Y27_N49 -to u0|tdc_0|carry0|cc|gen_reg_cc[57].reg_i
set_location_assignment LABCELL_X35_Y27_N51 -to u0|tdc_0|carry0|cc|gen_reg_cc[57].lcell_i
set_location_assignment FF_X35_Y27_N52 -to u0|tdc_0|carry0|cc|gen_reg_cc[58].reg_i
set_location_assignment LABCELL_X35_Y27_N54 -to u0|tdc_0|carry0|cc|gen_reg_cc[58].lcell_i
set_location_assignment FF_X35_Y27_N55 -to u0|tdc_0|carry0|cc|gen_reg_cc[59].reg_i
set_location_assignment LABCELL_X35_Y27_N57 -to u0|tdc_0|carry0|cc|gen_reg_cc[59].lcell_i
set_location_assignment FF_X35_Y27_N58 -to u0|tdc_0|carry0|cc|gen_reg_cc[60].reg_i
set_location_assignment LABCELL_X35_Y26_N0 -to u0|tdc_0|carry0|cc|gen_reg_cc[60].lcell_i
set_location_assignment FF_X35_Y26_N1 -to u0|tdc_0|carry0|cc|gen_reg_cc[61].reg_i
set_location_assignment LABCELL_X35_Y26_N3 -to u0|tdc_0|carry0|cc|gen_reg_cc[61].lcell_i
set_location_assignment FF_X35_Y26_N4 -to u0|tdc_0|carry0|cc|gen_reg_cc[62].reg_i
set_location_assignment LABCELL_X35_Y26_N6 -to u0|tdc_0|carry0|cc|gen_reg_cc[62].lcell_i
set_location_assignment FF_X35_Y26_N7 -to u0|tdc_0|carry0|cc|gen_reg_cc[63].reg_i
set_location_assignment LABCELL_X35_Y26_N9 -to u0|tdc_0|carry0|cc|gen_reg_cc[63].lcell_i
set_location_assignment FF_X35_Y26_N10 -to u0|tdc_0|carry0|cc|gen_reg_cc[64].reg_i
set_location_assignment LABCELL_X35_Y26_N12 -to u0|tdc_0|carry0|cc|gen_reg_cc[64].lcell_i
set_location_assignment FF_X35_Y26_N13 -to u0|tdc_0|carry0|cc|gen_reg_cc[65].reg_i
set_location_assignment LABCELL_X35_Y26_N15 -to u0|tdc_0|carry0|cc|gen_reg_cc[65].lcell_i
set_location_assignment FF_X35_Y26_N16 -to u0|tdc_0|carry0|cc|gen_reg_cc[66].reg_i
set_location_assignment LABCELL_X35_Y26_N18 -to u0|tdc_0|carry0|cc|gen_reg_cc[66].lcell_i
set_location_assignment FF_X35_Y26_N19 -to u0|tdc_0|carry0|cc|gen_reg_cc[67].reg_i
set_location_assignment LABCELL_X35_Y26_N21 -to u0|tdc_0|carry0|cc|gen_reg_cc[67].lcell_i
set_location_assignment FF_X35_Y26_N22 -to u0|tdc_0|carry0|cc|gen_reg_cc[68].reg_i
set_location_assignment LABCELL_X35_Y26_N24 -to u0|tdc_0|carry0|cc|gen_reg_cc[68].lcell_i
set_location_assignment FF_X35_Y26_N25 -to u0|tdc_0|carry0|cc|gen_reg_cc[69].reg_i
set_location_assignment LABCELL_X35_Y26_N27 -to u0|tdc_0|carry0|cc|gen_reg_cc[69].lcell_i
set_location_assignment FF_X35_Y26_N28 -to u0|tdc_0|carry0|cc|gen_reg_cc[70].reg_i
set_location_assignment LABCELL_X35_Y26_N30 -to u0|tdc_0|carry0|cc|gen_reg_cc[70].lcell_i
set_location_assignment FF_X35_Y26_N31 -to u0|tdc_0|carry0|cc|gen_reg_cc[71].reg_i
set_location_assignment LABCELL_X35_Y26_N33 -to u0|tdc_0|carry0|cc|gen_reg_cc[71].lcell_i
set_location_assignment FF_X35_Y26_N34 -to u0|tdc_0|carry0|cc|gen_reg_cc[72].reg_i
set_location_assignment LABCELL_X35_Y26_N36 -to u0|tdc_0|carry0|cc|gen_reg_cc[72].lcell_i
set_location_assignment FF_X35_Y26_N37 -to u0|tdc_0|carry0|cc|gen_reg_cc[73].reg_i
set_location_assignment LABCELL_X35_Y26_N39 -to u0|tdc_0|carry0|cc|gen_reg_cc[73].lcell_i
set_location_assignment FF_X35_Y26_N40 -to u0|tdc_0|carry0|cc|gen_reg_cc[74].reg_i
set_location_assignment LABCELL_X35_Y26_N42 -to u0|tdc_0|carry0|cc|gen_reg_cc[74].lcell_i
set_location_assignment FF_X35_Y26_N43 -to u0|tdc_0|carry0|cc|gen_reg_cc[75].reg_i
set_location_assignment LABCELL_X35_Y26_N45 -to u0|tdc_0|carry0|cc|gen_reg_cc[75].lcell_i
set_location_assignment FF_X35_Y26_N46 -to u0|tdc_0|carry0|cc|gen_reg_cc[76].reg_i
set_location_assignment LABCELL_X35_Y26_N48 -to u0|tdc_0|carry0|cc|gen_reg_cc[76].lcell_i
set_location_assignment FF_X35_Y26_N49 -to u0|tdc_0|carry0|cc|gen_reg_cc[77].reg_i
set_location_assignment LABCELL_X35_Y26_N51 -to u0|tdc_0|carry0|cc|gen_reg_cc[77].lcell_i
set_location_assignment FF_X35_Y26_N52 -to u0|tdc_0|carry0|cc|gen_reg_cc[78].reg_i
set_location_assignment LABCELL_X35_Y26_N54 -to u0|tdc_0|carry0|cc|gen_reg_cc[78].lcell_i
set_location_assignment FF_X35_Y26_N55 -to u0|tdc_0|carry0|cc|gen_reg_cc[79].reg_i
set_location_assignment LABCELL_X35_Y26_N57 -to u0|tdc_0|carry0|cc|gen_reg_cc[79].lcell_i
set_location_assignment FF_X35_Y26_N58 -to u0|tdc_0|carry0|cc|gen_reg_cc[80].reg_i
set_location_assignment LABCELL_X35_Y25_N0 -to u0|tdc_0|carry0|cc|gen_reg_cc[80].lcell_i
set_location_assignment FF_X35_Y25_N1 -to u0|tdc_0|carry0|cc|gen_reg_cc[81].reg_i
set_location_assignment LABCELL_X35_Y25_N3 -to u0|tdc_0|carry0|cc|gen_reg_cc[81].lcell_i
set_location_assignment FF_X35_Y25_N4 -to u0|tdc_0|carry0|cc|gen_reg_cc[82].reg_i
set_location_assignment LABCELL_X35_Y25_N6 -to u0|tdc_0|carry0|cc|gen_reg_cc[82].lcell_i
set_location_assignment FF_X35_Y25_N7 -to u0|tdc_0|carry0|cc|gen_reg_cc[83].reg_i
set_location_assignment LABCELL_X35_Y25_N9 -to u0|tdc_0|carry0|cc|gen_reg_cc[83].lcell_i
set_location_assignment FF_X35_Y25_N10 -to u0|tdc_0|carry0|cc|gen_reg_cc[84].reg_i
set_location_assignment LABCELL_X35_Y25_N12 -to u0|tdc_0|carry0|cc|gen_reg_cc[84].lcell_i
set_location_assignment FF_X35_Y25_N13 -to u0|tdc_0|carry0|cc|gen_reg_cc[85].reg_i
set_location_assignment LABCELL_X35_Y25_N15 -to u0|tdc_0|carry0|cc|gen_reg_cc[85].lcell_i
set_location_assignment FF_X35_Y25_N16 -to u0|tdc_0|carry0|cc|gen_reg_cc[86].reg_i
set_location_assignment LABCELL_X35_Y25_N18 -to u0|tdc_0|carry0|cc|gen_reg_cc[86].lcell_i
set_location_assignment FF_X35_Y25_N19 -to u0|tdc_0|carry0|cc|gen_reg_cc[87].reg_i
set_location_assignment LABCELL_X35_Y25_N21 -to u0|tdc_0|carry0|cc|gen_reg_cc[87].lcell_i
set_location_assignment FF_X35_Y25_N22 -to u0|tdc_0|carry0|cc|gen_reg_cc[88].reg_i
set_location_assignment LABCELL_X35_Y25_N24 -to u0|tdc_0|carry0|cc|gen_reg_cc[88].lcell_i
set_location_assignment FF_X35_Y25_N25 -to u0|tdc_0|carry0|cc|gen_reg_cc[89].reg_i
set_location_assignment LABCELL_X35_Y25_N27 -to u0|tdc_0|carry0|cc|gen_reg_cc[89].lcell_i
set_location_assignment FF_X35_Y25_N28 -to u0|tdc_0|carry0|cc|gen_reg_cc[90].reg_i
set_location_assignment LABCELL_X35_Y25_N30 -to u0|tdc_0|carry0|cc|gen_reg_cc[90].lcell_i
set_location_assignment FF_X35_Y25_N31 -to u0|tdc_0|carry0|cc|gen_reg_cc[91].reg_i
set_location_assignment LABCELL_X35_Y25_N33 -to u0|tdc_0|carry0|cc|gen_reg_cc[91].lcell_i
set_location_assignment FF_X35_Y25_N34 -to u0|tdc_0|carry0|cc|gen_reg_cc[92].reg_i
set_location_assignment LABCELL_X35_Y25_N36 -to u0|tdc_0|carry0|cc|gen_reg_cc[92].lcell_i
set_location_assignment FF_X35_Y25_N37 -to u0|tdc_0|carry0|cc|gen_reg_cc[93].reg_i
set_location_assignment LABCELL_X35_Y25_N39 -to u0|tdc_0|carry0|cc|gen_reg_cc[93].lcell_i
set_location_assignment FF_X35_Y25_N40 -to u0|tdc_0|carry0|cc|gen_reg_cc[94].reg_i
set_location_assignment LABCELL_X35_Y25_N42 -to u0|tdc_0|carry0|cc|gen_reg_cc[94].lcell_i
set_location_assignment FF_X35_Y25_N43 -to u0|tdc_0|carry0|cc|gen_reg_cc[95].reg_i
set_location_assignment LABCELL_X35_Y25_N45 -to u0|tdc_0|carry0|cc|gen_reg_cc[95].lcell_i
set_location_assignment FF_X35_Y25_N46 -to u0|tdc_0|carry0|cc|gen_reg_cc[96].reg_i
set_location_assignment LABCELL_X35_Y25_N48 -to u0|tdc_0|carry0|cc|gen_reg_cc[96].lcell_i
set_location_assignment FF_X35_Y25_N49 -to u0|tdc_0|carry0|cc|gen_reg_cc[97].reg_i
set_location_assignment LABCELL_X35_Y25_N51 -to u0|tdc_0|carry0|cc|gen_reg_cc[97].lcell_i
set_location_assignment FF_X35_Y25_N52 -to u0|tdc_0|carry0|cc|gen_reg_cc[98].reg_i
set_location_assignment LABCELL_X35_Y25_N54 -to u0|tdc_0|carry0|cc|gen_reg_cc[98].lcell_i
set_location_assignment FF_X35_Y25_N55 -to u0|tdc_0|carry0|cc|gen_reg_cc[99].reg_i
set_location_assignment LABCELL_X35_Y25_N57 -to u0|tdc_0|carry0|cc|gen_reg_cc[99].lcell_i
set_location_assignment FF_X35_Y25_N58 -to u0|tdc_0|carry0|cc|gen_reg_cc[100].reg_i
set_location_assignment LABCELL_X35_Y24_N0 -to u0|tdc_0|carry0|cc|gen_reg_cc[100].lcell_i
set_location_assignment FF_X35_Y24_N1 -to u0|tdc_0|carry0|cc|gen_reg_cc[101].reg_i
set_location_assignment LABCELL_X35_Y24_N3 -to u0|tdc_0|carry0|cc|gen_reg_cc[101].lcell_i
set_location_assignment FF_X35_Y24_N4 -to u0|tdc_0|carry0|cc|gen_reg_cc[102].reg_i
set_location_assignment LABCELL_X35_Y24_N6 -to u0|tdc_0|carry0|cc|gen_reg_cc[102].lcell_i
set_location_assignment FF_X35_Y24_N7 -to u0|tdc_0|carry0|cc|gen_reg_cc[103].reg_i
set_location_assignment LABCELL_X35_Y24_N9 -to u0|tdc_0|carry0|cc|gen_reg_cc[103].lcell_i
set_location_assignment FF_X35_Y24_N10 -to u0|tdc_0|carry0|cc|gen_reg_cc[104].reg_i
set_location_assignment LABCELL_X35_Y24_N12 -to u0|tdc_0|carry0|cc|gen_reg_cc[104].lcell_i
set_location_assignment FF_X35_Y24_N13 -to u0|tdc_0|carry0|cc|gen_reg_cc[105].reg_i
set_location_assignment LABCELL_X35_Y24_N15 -to u0|tdc_0|carry0|cc|gen_reg_cc[105].lcell_i
set_location_assignment FF_X35_Y24_N16 -to u0|tdc_0|carry0|cc|gen_reg_cc[106].reg_i
set_location_assignment LABCELL_X35_Y24_N18 -to u0|tdc_0|carry0|cc|gen_reg_cc[106].lcell_i
set_location_assignment FF_X35_Y24_N19 -to u0|tdc_0|carry0|cc|gen_reg_cc[107].reg_i
set_location_assignment LABCELL_X35_Y24_N21 -to u0|tdc_0|carry0|cc|gen_reg_cc[107].lcell_i
set_location_assignment FF_X35_Y24_N22 -to u0|tdc_0|carry0|cc|gen_reg_cc[108].reg_i
set_location_assignment LABCELL_X35_Y24_N24 -to u0|tdc_0|carry0|cc|gen_reg_cc[108].lcell_i
set_location_assignment FF_X35_Y24_N25 -to u0|tdc_0|carry0|cc|gen_reg_cc[109].reg_i
set_location_assignment LABCELL_X35_Y24_N27 -to u0|tdc_0|carry0|cc|gen_reg_cc[109].lcell_i
set_location_assignment FF_X35_Y24_N28 -to u0|tdc_0|carry0|cc|gen_reg_cc[110].reg_i
set_location_assignment LABCELL_X35_Y24_N30 -to u0|tdc_0|carry0|cc|gen_reg_cc[110].lcell_i
set_location_assignment FF_X35_Y24_N31 -to u0|tdc_0|carry0|cc|gen_reg_cc[111].reg_i
set_location_assignment LABCELL_X35_Y24_N33 -to u0|tdc_0|carry0|cc|gen_reg_cc[111].lcell_i
set_location_assignment FF_X35_Y24_N34 -to u0|tdc_0|carry0|cc|gen_reg_cc[112].reg_i
set_location_assignment LABCELL_X35_Y24_N36 -to u0|tdc_0|carry0|cc|gen_reg_cc[112].lcell_i
set_location_assignment FF_X35_Y24_N37 -to u0|tdc_0|carry0|cc|gen_reg_cc[113].reg_i
set_location_assignment LABCELL_X35_Y24_N39 -to u0|tdc_0|carry0|cc|gen_reg_cc[113].lcell_i
set_location_assignment FF_X35_Y24_N40 -to u0|tdc_0|carry0|cc|gen_reg_cc[114].reg_i
set_location_assignment LABCELL_X35_Y24_N42 -to u0|tdc_0|carry0|cc|gen_reg_cc[114].lcell_i
set_location_assignment FF_X35_Y24_N43 -to u0|tdc_0|carry0|cc|gen_reg_cc[115].reg_i
set_location_assignment LABCELL_X35_Y24_N45 -to u0|tdc_0|carry0|cc|gen_reg_cc[115].lcell_i
set_location_assignment FF_X35_Y24_N46 -to u0|tdc_0|carry0|cc|gen_reg_cc[116].reg_i
set_location_assignment LABCELL_X35_Y24_N48 -to u0|tdc_0|carry0|cc|gen_reg_cc[116].lcell_i
set_location_assignment FF_X35_Y24_N49 -to u0|tdc_0|carry0|cc|gen_reg_cc[117].reg_i
set_location_assignment LABCELL_X35_Y24_N51 -to u0|tdc_0|carry0|cc|gen_reg_cc[117].lcell_i
set_location_assignment FF_X35_Y24_N52 -to u0|tdc_0|carry0|cc|gen_reg_cc[118].reg_i
set_location_assignment LABCELL_X35_Y24_N54 -to u0|tdc_0|carry0|cc|gen_reg_cc[118].lcell_i
set_location_assignment FF_X35_Y24_N55 -to u0|tdc_0|carry0|cc|gen_reg_cc[119].reg_i
set_location_assignment LABCELL_X35_Y24_N57 -to u0|tdc_0|carry0|cc|gen_reg_cc[119].lcell_i
set_location_assignment FF_X35_Y24_N58 -to u0|tdc_0|carry0|cc|gen_reg_cc[120].reg_i
set_location_assignment LABCELL_X35_Y23_N0 -to u0|tdc_0|carry0|cc|gen_reg_cc[120].lcell_i
set_location_assignment FF_X35_Y23_N1 -to u0|tdc_0|carry0|cc|gen_reg_cc[121].reg_i
set_location_assignment LABCELL_X35_Y23_N3 -to u0|tdc_0|carry0|cc|gen_reg_cc[121].lcell_i
set_location_assignment FF_X35_Y23_N4 -to u0|tdc_0|carry0|cc|gen_reg_cc[122].reg_i
set_location_assignment LABCELL_X35_Y23_N6 -to u0|tdc_0|carry0|cc|gen_reg_cc[122].lcell_i
set_location_assignment FF_X35_Y23_N7 -to u0|tdc_0|carry0|cc|gen_reg_cc[123].reg_i
set_location_assignment LABCELL_X35_Y23_N9 -to u0|tdc_0|carry0|cc|gen_reg_cc[123].lcell_i
set_location_assignment FF_X35_Y23_N10 -to u0|tdc_0|carry0|cc|gen_reg_cc[124].reg_i
set_location_assignment LABCELL_X35_Y23_N12 -to u0|tdc_0|carry0|cc|gen_reg_cc[124].lcell_i
set_location_assignment FF_X35_Y23_N13 -to u0|tdc_0|carry0|cc|gen_reg_cc[125].reg_i
set_location_assignment LABCELL_X35_Y23_N15 -to u0|tdc_0|carry0|cc|gen_reg_cc[125].lcell_i
set_location_assignment FF_X35_Y23_N16 -to u0|tdc_0|carry0|cc|gen_reg_cc[126].reg_i
set_location_assignment LABCELL_X35_Y23_N18 -to u0|tdc_0|carry0|cc|gen_reg_cc[126].lcell_i
set_location_assignment FF_X35_Y23_N19 -to u0|tdc_0|carry0|cc|gen_reg_cc[127].reg_i
set_location_assignment LABCELL_X35_Y23_N21 -to u0|tdc_0|carry0|cc|gen_reg_cc[127].lcell_i
set_location_assignment FF_X35_Y23_N22 -to u0|tdc_0|carry0|cc|reg_last

set_location_assignment FF_X35_Y30_N55 -to "soc_system:u0|tdc_top:tdc_0|carry_top:carry0|carry_chain:cc|val_out"
set_location_assignment MLABCELL_X34_Y29_N0 -to "soc_system:u0|tdc_top:tdc_0|carry_top:carry0|wInputA[0]"

#============================================================
# Pulsegenerator
#============================================================
set_location_assignment FF_X33_Y30_N55 -to "soc_system:u0|pulsegenerator:pulsegenerator|M_AVST_VALID_P[3]"
set_location_assignment FF_X33_Y29_N1 -to "soc_system:u0|pulsegenerator:pulsegenerator|M_AVST_DATA_P[3][0]"


#============================================================
# Turn off register merging
#============================================================
set_instance_assignment -name DONT_MERGE_REGISTER ON -to "soc_system:u0|pulsegenerator:pulsegenerator"
set_instance_assignment -name DONT_MERGE_REGISTER ON -to "soc_system:u0|tdc_top:tdc_0"
set_instance_assignment -name DONT_MERGE_REGISTER ON -to "soc_system:u0|altera_avalon_mm_clock_crossing_bridge:ipsync_to_aes_delay"

#============================================================
# Logic Lock Regions
#============================================================
set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
set_global_assignment -name LL_ENABLED ON -section_id pulsegenerator
set_global_assignment -name LL_AUTO_SIZE OFF -section_id pulsegenerator
set_global_assignment -name LL_STATE LOCKED -section_id pulsegenerator
set_global_assignment -name LL_RESERVED OFF -section_id pulsegenerator
set_global_assignment -name LL_CORE_ONLY OFF -section_id pulsegenerator
set_global_assignment -name LL_SECURITY_ROUTING_INTERFACE OFF -section_id pulsegenerator
set_global_assignment -name LL_IGNORE_IO_BANK_SECURITY_CONSTRAINT OFF -section_id pulsegenerator
set_global_assignment -name LL_PR_REGION OFF -section_id pulsegenerator
set_global_assignment -name LL_ROUTING_REGION_EXPANSION_SIZE 2147483647 -section_id pulsegenerator
set_global_assignment -name LL_WIDTH 7 -section_id pulsegenerator
set_global_assignment -name LL_HEIGHT 4 -section_id pulsegenerator
set_global_assignment -name LL_ORIGIN X27_Y28 -section_id pulsegenerator
set_global_assignment -name LL_ENABLED ON -section_id shell_logic
set_global_assignment -name LL_AUTO_SIZE OFF -section_id shell_logic
set_global_assignment -name LL_STATE LOCKED -section_id shell_logic
set_global_assignment -name LL_RESERVED OFF -section_id shell_logic
set_global_assignment -name LL_CORE_ONLY OFF -section_id shell_logic
set_global_assignment -name LL_SECURITY_ROUTING_INTERFACE OFF -section_id shell_logic
set_global_assignment -name LL_IGNORE_IO_BANK_SECURITY_CONSTRAINT OFF -section_id shell_logic
set_global_assignment -name LL_PR_REGION OFF -section_id shell_logic
set_global_assignment -name LL_ROUTING_REGION_EXPANSION_SIZE 2147483647 -section_id shell_logic
set_global_assignment -name LL_WIDTH 50 -section_id shell_logic
set_global_assignment -name LL_HEIGHT 31 -section_id shell_logic
set_global_assignment -name LL_ORIGIN X1_Y50 -section_id shell_logic
set_global_assignment -name LL_ENABLED ON -section_id aes
set_global_assignment -name LL_AUTO_SIZE OFF -section_id aes
set_global_assignment -name LL_STATE LOCKED -section_id aes
set_global_assignment -name LL_RESERVED OFF -section_id aes
set_global_assignment -name LL_CORE_ONLY OFF -section_id aes
set_global_assignment -name LL_SECURITY_ROUTING_INTERFACE OFF -section_id aes
set_global_assignment -name LL_IGNORE_IO_BANK_SECURITY_CONSTRAINT OFF -section_id aes
set_global_assignment -name LL_PR_REGION OFF -section_id aes
set_global_assignment -name LL_ROUTING_REGION_EXPANSION_SIZE 2147483647 -section_id aes
set_global_assignment -name LL_WIDTH 24 -section_id aes
set_global_assignment -name LL_HEIGHT 21 -section_id aes
set_global_assignment -name LL_ORIGIN X10_Y7 -section_id aes
set_global_assignment -name LL_ENABLED ON -section_id tdc
set_global_assignment -name LL_AUTO_SIZE OFF -section_id tdc
set_global_assignment -name LL_STATE LOCKED -section_id tdc
set_global_assignment -name LL_RESERVED OFF -section_id tdc
set_global_assignment -name LL_CORE_ONLY OFF -section_id tdc
set_global_assignment -name LL_SECURITY_ROUTING_INTERFACE OFF -section_id tdc
set_global_assignment -name LL_IGNORE_IO_BANK_SECURITY_CONSTRAINT OFF -section_id tdc
set_global_assignment -name LL_PR_REGION OFF -section_id tdc
set_global_assignment -name LL_ROUTING_REGION_EXPANSION_SIZE 2147483647 -section_id tdc
set_global_assignment -name LL_WIDTH 10 -section_id tdc
set_global_assignment -name LL_HEIGHT 9 -section_id tdc
set_global_assignment -name LL_ORIGIN X34_Y23 -section_id tdc
set_global_assignment -name LL_ENABLED ON -section_id carry_chain
set_global_assignment -name LL_AUTO_SIZE OFF -section_id carry_chain
set_global_assignment -name LL_STATE LOCKED -section_id carry_chain
set_global_assignment -name LL_RESERVED ON -section_id carry_chain
set_global_assignment -name LL_CORE_ONLY OFF -section_id carry_chain
set_global_assignment -name LL_SECURITY_ROUTING_INTERFACE OFF -section_id carry_chain
set_global_assignment -name LL_IGNORE_IO_BANK_SECURITY_CONSTRAINT OFF -section_id carry_chain
set_global_assignment -name LL_PR_REGION ON -section_id carry_chain
set_global_assignment -name LL_ROUTING_REGION_EXPANSION_SIZE 0 -section_id carry_chain
set_global_assignment -name LL_WIDTH 1 -section_id carry_chain
set_global_assignment -name LL_HEIGHT 8 -section_id carry_chain
set_global_assignment -name LL_ORIGIN X35_Y23 -section_id carry_chain
set_global_assignment -name LL_ROUTING_REGION EXPANDED -section_id carry_chain

set_instance_assignment -name LL_MEMBER_OF pulsegenerator -to "soc_system:u0|pulsegenerator:pulsegenerator" -section_id pulsegenerator


set_instance_assignment -name LL_MEMBER_OF aes -to "soc_system:u0|aes:aes" -section_id aes
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_avalon_dc_fifo:ip_sync_to_pulsegenerator_cdc" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_avalon_dc_fifo:tdc_to_dma_dc_fifo" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_avalon_mm_clock_crossing_bridge:ipsync_bridge" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_avalon_mm_clock_crossing_bridge:ipsync_to_aes_delay" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_avalon_mm_clock_crossing_bridge:phi_pll_reconfig_cdc" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_avalon_mm_clock_crossing_bridge:pulsegenerator_cdc" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_avalon_mm_clock_crossing_bridge:theta_pll_reconfig_cdc" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_pll_reconfig_top:phi_pll_reconfig" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|altera_pll_reconfig_top:theta_pll_reconfig" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_DMA_to_SDRAM:dma_to_sdram" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_hps_0:hps_0" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_0:mm_interconnect_0" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_1:mm_interconnect_1" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_2:mm_interconnect_2" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_3:mm_interconnect_3" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_4:mm_interconnect_4" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_5:mm_interconnect_5" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_6:mm_interconnect_6" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_7:mm_interconnect_7" -section_id shell_logic
set_instance_assignment -name LL_MEMBER_OF shell_logic -to "soc_system:u0|soc_system_mm_interconnect_8:mm_interconnect_8" -section_id shell_logic

set_instance_assignment -name LL_MEMBER_OF tdc -to "soc_system:u0|tdc_top:tdc_0" -section_id tdc

set_instance_assignment -name LL_MEMBER_OF carry_chain -to "soc_system:u0|tdc_top:tdc_0|carry_top:carry0|carry_chain:cc" -section_id carry_chain
set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top
