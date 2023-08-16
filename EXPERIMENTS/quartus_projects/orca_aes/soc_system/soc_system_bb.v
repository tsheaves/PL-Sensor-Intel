
module soc_system (
	clk_clk,
	locked_phi_in_export,
	locked_phi_out_export,
	locked_theta_in_export,
	locked_theta_out_export,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	orca_reset_in_reset,
	orca_reset_out_export,
	reset_phi_in_reset,
	reset_phi_out_export,
	reset_theta_in_reset,
	reset_theta_out_export,
	tdc_reset_in_reset,
	tdc_reset_out_export,
	theta_clks_refclk_clk);	

	input		clk_clk;
	input	[31:0]	locked_phi_in_export;
	output		locked_phi_out_export;
	input	[31:0]	locked_theta_in_export;
	output		locked_theta_out_export;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	input		orca_reset_in_reset;
	output	[31:0]	orca_reset_out_export;
	input		reset_phi_in_reset;
	output	[31:0]	reset_phi_out_export;
	input		reset_theta_in_reset;
	output	[31:0]	reset_theta_out_export;
	input		tdc_reset_in_reset;
	output	[31:0]	tdc_reset_out_export;
	input		theta_clks_refclk_clk;
endmodule
