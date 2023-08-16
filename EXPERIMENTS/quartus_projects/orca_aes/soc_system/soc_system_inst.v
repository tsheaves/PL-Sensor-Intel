	soc_system u0 (
		.clk_clk                 (<connected-to-clk_clk>),                 //               clk.clk
		.locked_phi_in_export    (<connected-to-locked_phi_in_export>),    //     locked_phi_in.export
		.locked_phi_out_export   (<connected-to-locked_phi_out_export>),   //    locked_phi_out.export
		.locked_theta_in_export  (<connected-to-locked_theta_in_export>),  //   locked_theta_in.export
		.locked_theta_out_export (<connected-to-locked_theta_out_export>), //  locked_theta_out.export
		.memory_mem_a            (<connected-to-memory_mem_a>),            //            memory.mem_a
		.memory_mem_ba           (<connected-to-memory_mem_ba>),           //                  .mem_ba
		.memory_mem_ck           (<connected-to-memory_mem_ck>),           //                  .mem_ck
		.memory_mem_ck_n         (<connected-to-memory_mem_ck_n>),         //                  .mem_ck_n
		.memory_mem_cke          (<connected-to-memory_mem_cke>),          //                  .mem_cke
		.memory_mem_cs_n         (<connected-to-memory_mem_cs_n>),         //                  .mem_cs_n
		.memory_mem_ras_n        (<connected-to-memory_mem_ras_n>),        //                  .mem_ras_n
		.memory_mem_cas_n        (<connected-to-memory_mem_cas_n>),        //                  .mem_cas_n
		.memory_mem_we_n         (<connected-to-memory_mem_we_n>),         //                  .mem_we_n
		.memory_mem_reset_n      (<connected-to-memory_mem_reset_n>),      //                  .mem_reset_n
		.memory_mem_dq           (<connected-to-memory_mem_dq>),           //                  .mem_dq
		.memory_mem_dqs          (<connected-to-memory_mem_dqs>),          //                  .mem_dqs
		.memory_mem_dqs_n        (<connected-to-memory_mem_dqs_n>),        //                  .mem_dqs_n
		.memory_mem_odt          (<connected-to-memory_mem_odt>),          //                  .mem_odt
		.memory_mem_dm           (<connected-to-memory_mem_dm>),           //                  .mem_dm
		.memory_oct_rzqin        (<connected-to-memory_oct_rzqin>),        //                  .oct_rzqin
		.orca_reset_in_reset     (<connected-to-orca_reset_in_reset>),     //     orca_reset_in.reset
		.orca_reset_out_export   (<connected-to-orca_reset_out_export>),   //    orca_reset_out.export
		.reset_phi_in_reset      (<connected-to-reset_phi_in_reset>),      //      reset_phi_in.reset
		.reset_phi_out_export    (<connected-to-reset_phi_out_export>),    //     reset_phi_out.export
		.reset_theta_in_reset    (<connected-to-reset_theta_in_reset>),    //    reset_theta_in.reset
		.reset_theta_out_export  (<connected-to-reset_theta_out_export>),  //   reset_theta_out.export
		.tdc_reset_in_reset      (<connected-to-tdc_reset_in_reset>),      //      tdc_reset_in.reset
		.tdc_reset_out_export    (<connected-to-tdc_reset_out_export>),    //     tdc_reset_out.export
		.theta_clks_refclk_clk   (<connected-to-theta_clks_refclk_clk>)    // theta_clks_refclk.clk
	);

