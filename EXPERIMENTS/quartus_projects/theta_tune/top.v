module top(
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

wire [31:0]
    theta_pll_reset,
    phi_pll_reset,
    pulsegenerator_reset;

wire
    theta_pll_locked,
    phi_pll_locked;

//=======================================================
//  Structural coding
//=======================================================
soc_system u0(
    .clk_clk(FPGA_CLK1_50),
    .memory_mem_a(HPS_DDR3_ADDR),
    .memory_mem_ba(HPS_DDR3_BA),
    .memory_mem_ck(HPS_DDR3_CK_P),
    .memory_mem_ck_n(HPS_DDR3_CK_N),
    .memory_mem_cke(HPS_DDR3_CKE),
    .memory_mem_cs_n(HPS_DDR3_CS_N),
    .memory_mem_ras_n(HPS_DDR3_RAS_N),
    .memory_mem_cas_n(HPS_DDR3_CAS_N),
    .memory_mem_we_n(HPS_DDR3_WE_N),
    .memory_mem_reset_n(HPS_DDR3_RESET_N),
    .memory_mem_dq(HPS_DDR3_DQ),
    .memory_mem_dqs(HPS_DDR3_DQS_P),
    .memory_mem_dqs_n(HPS_DDR3_DQS_N),
    .memory_mem_odt(HPS_DDR3_ODT),
    .memory_mem_dm(HPS_DDR3_DM),
    .memory_oct_rzqin(HPS_DDR3_RZQ),
    .reset_phi_in_reset(phi_pll_reset[0]),
    .reset_phi_out_export(phi_pll_reset),
    .reset_theta_in_reset(theta_pll_reset[0] | ~phi_pll_locked),
    .reset_theta_out_export(theta_pll_reset),
    .locked_phi_in_export({{31{1'b0}}, phi_pll_locked}),
    .locked_phi_out_export(phi_pll_locked),
    .locked_theta_in_export({{31{1'b0}}, theta_pll_locked}),
    .locked_theta_out_export(theta_pll_locked),
    .pulse_gen_reset_in_reset(pulsegenerator_reset[0]),
    .pulse_gen_reset_out_export(pulsegenerator_reset)
);

endmodule
