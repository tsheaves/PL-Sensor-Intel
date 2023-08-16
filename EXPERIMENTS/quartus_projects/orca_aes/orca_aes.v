module orca_aes(
    //////////// CLOCK //////////
    input               FPGA_CLK1_50,
    input               FPGA_CLK2_50,
    input               FPGA_CLK3_50,

    //////////// HPS //////////
    output   [14: 0]    HPS_DDR3_ADDR,
    output   [ 2: 0]    HPS_DDR3_BA,
    output              HPS_DDR3_CAS_N,
    output              HPS_DDR3_CK_N,
    output              HPS_DDR3_CK_P,
    output              HPS_DDR3_CKE,
    output              HPS_DDR3_CS_N,
    output   [ 3: 0]    HPS_DDR3_DM,
    inout    [31: 0]    HPS_DDR3_DQ,
    inout    [ 3: 0]    HPS_DDR3_DQS_N,
    inout    [ 3: 0]    HPS_DDR3_DQS_P,
    output              HPS_DDR3_ODT,
    output              HPS_DDR3_RAS_N,
    output              HPS_DDR3_RESET_N,
    input               HPS_DDR3_RZQ,
    output              HPS_DDR3_WE_N
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
//wire 	hps_fpga_reset_n, 
//		phase_done, 
//		phase_en, 
//		phase_updn, 
//		tdc_pll_locked;
//
//
//wire [4:0] phase_cntsel;

wire [31:0] theta_pll_reset, phi_pll_reset, tdc_reset, aes_reset;
wire theta_pll_locked, phi_pll_locked;

//=======================================================
//  Structural coding
//=======================================================
	soc_system u0(
		.clk_clk(FPGA_CLK1_50),                                      //                            	 .clk.cl
		.memory_mem_a(HPS_DDR3_ADDR),                                //                         		 .memory.mem_a
		.memory_mem_ba(HPS_DDR3_BA),                                 //                               .mem_ba
		.memory_mem_ck(HPS_DDR3_CK_P),                               //                               .mem_ck
		.memory_mem_ck_n(HPS_DDR3_CK_N),                             //                               .mem_ck_n
		.memory_mem_cke(HPS_DDR3_CKE),                               //                               .mem_cke
		.memory_mem_cs_n(HPS_DDR3_CS_N),                             //                               .mem_cs_n
		.memory_mem_ras_n(HPS_DDR3_RAS_N),                           //                               .mem_ras_n
		.memory_mem_cas_n(HPS_DDR3_CAS_N),                           //                               .mem_cas_n
		.memory_mem_we_n(HPS_DDR3_WE_N),                             //                               .mem_we_n
		.memory_mem_reset_n(HPS_DDR3_RESET_N),                       //                               .mem_reset_n
		.memory_mem_dq(HPS_DDR3_DQ),                                 //                               .mem_dq
		.memory_mem_dqs(HPS_DDR3_DQS_P),                             //                               .mem_dqs
		.memory_mem_dqs_n(HPS_DDR3_DQS_N),                           //                               .mem_dqs_n
		.memory_mem_odt(HPS_DDR3_ODT),                               //                               .mem_odt
		.memory_mem_dm(HPS_DDR3_DM),                                 //                               .mem_dm
		.memory_oct_rzqin(HPS_DDR3_RZQ),                             //                               .oct_rzqin
		.reset_phi_in_reset(phi_pll_reset[0]),        					 //                               reset_phi_in.reset
		.reset_phi_out_export(phi_pll_reset),          					 //                               reset_phi_out.export
		.reset_theta_in_reset(theta_pll_reset[0] | ~phi_pll_locked), //                               reset_theta_in.reset
		.reset_theta_out_export(theta_pll_reset),      					 //                               reset_theta_out.export
		.locked_phi_in_export({{31{1'b0}}, phi_pll_locked}),         //                               locked_phi_in.export    
		.locked_phi_out_export(phi_pll_locked),                      //                               locked_phi_out.export
		.locked_theta_in_export({{31{1'b0}}, theta_pll_locked}),     //                               locked_theta_in.export
		.locked_theta_out_export(theta_pll_locked),                  //                               locked_theta_out.export
		.tdc_reset_in_reset(tdc_reset[0]),                 
		.tdc_reset_out_export(tdc_reset | ~theta_pll_locked),
		.aes_reset_out_export(aes_reset),
		.aes_reset_in_reset(aes_reset[0])
	);

endmodule
