// soc_system_mm_interconnect_4.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 22.1 917

`timescale 1 ps / 1 ps
module soc_system_mm_interconnect_4 (
		input  wire        shell_pll_outclk1_clk,                              //                            shell_pll_outclk1.clk
		input  wire        ipsync_bridge_m0_reset_reset_bridge_in_reset_reset, // ipsync_bridge_m0_reset_reset_bridge_in_reset.reset
		input  wire [9:0]  ipsync_bridge_m0_address,                           //                             ipsync_bridge_m0.address
		output wire        ipsync_bridge_m0_waitrequest,                       //                                             .waitrequest
		input  wire [0:0]  ipsync_bridge_m0_burstcount,                        //                                             .burstcount
		input  wire [3:0]  ipsync_bridge_m0_byteenable,                        //                                             .byteenable
		input  wire        ipsync_bridge_m0_read,                              //                                             .read
		output wire [31:0] ipsync_bridge_m0_readdata,                          //                                             .readdata
		output wire        ipsync_bridge_m0_readdatavalid,                     //                                             .readdatavalid
		input  wire        ipsync_bridge_m0_write,                             //                                             .write
		input  wire [31:0] ipsync_bridge_m0_writedata,                         //                                             .writedata
		input  wire        ipsync_bridge_m0_debugaccess,                       //                                             .debugaccess
		output wire [7:0]  ip_sync_avalon_slave_address,                       //                         ip_sync_avalon_slave.address
		output wire        ip_sync_avalon_slave_write,                         //                                             .write
		output wire        ip_sync_avalon_slave_read,                          //                                             .read
		input  wire [31:0] ip_sync_avalon_slave_readdata,                      //                                             .readdata
		output wire [31:0] ip_sync_avalon_slave_writedata,                     //                                             .writedata
		output wire [0:0]  ip_sync_avalon_slave_burstcount,                    //                                             .burstcount
		output wire [3:0]  ip_sync_avalon_slave_byteenable,                    //                                             .byteenable
		input  wire        ip_sync_avalon_slave_readdatavalid,                 //                                             .readdatavalid
		input  wire        ip_sync_avalon_slave_waitrequest                    //                                             .waitrequest
	);

	wire         ipsync_bridge_m0_translator_avalon_universal_master_0_waitrequest;   // ip_sync_avalon_slave_translator:uav_waitrequest -> ipsync_bridge_m0_translator:uav_waitrequest
	wire  [31:0] ipsync_bridge_m0_translator_avalon_universal_master_0_readdata;      // ip_sync_avalon_slave_translator:uav_readdata -> ipsync_bridge_m0_translator:uav_readdata
	wire         ipsync_bridge_m0_translator_avalon_universal_master_0_debugaccess;   // ipsync_bridge_m0_translator:uav_debugaccess -> ip_sync_avalon_slave_translator:uav_debugaccess
	wire   [9:0] ipsync_bridge_m0_translator_avalon_universal_master_0_address;       // ipsync_bridge_m0_translator:uav_address -> ip_sync_avalon_slave_translator:uav_address
	wire         ipsync_bridge_m0_translator_avalon_universal_master_0_read;          // ipsync_bridge_m0_translator:uav_read -> ip_sync_avalon_slave_translator:uav_read
	wire   [3:0] ipsync_bridge_m0_translator_avalon_universal_master_0_byteenable;    // ipsync_bridge_m0_translator:uav_byteenable -> ip_sync_avalon_slave_translator:uav_byteenable
	wire         ipsync_bridge_m0_translator_avalon_universal_master_0_readdatavalid; // ip_sync_avalon_slave_translator:uav_readdatavalid -> ipsync_bridge_m0_translator:uav_readdatavalid
	wire         ipsync_bridge_m0_translator_avalon_universal_master_0_lock;          // ipsync_bridge_m0_translator:uav_lock -> ip_sync_avalon_slave_translator:uav_lock
	wire         ipsync_bridge_m0_translator_avalon_universal_master_0_write;         // ipsync_bridge_m0_translator:uav_write -> ip_sync_avalon_slave_translator:uav_write
	wire  [31:0] ipsync_bridge_m0_translator_avalon_universal_master_0_writedata;     // ipsync_bridge_m0_translator:uav_writedata -> ip_sync_avalon_slave_translator:uav_writedata
	wire   [2:0] ipsync_bridge_m0_translator_avalon_universal_master_0_burstcount;    // ipsync_bridge_m0_translator:uav_burstcount -> ip_sync_avalon_slave_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (10),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (10),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) ipsync_bridge_m0_translator (
		.clk                    (shell_pll_outclk1_clk),                                               //                       clk.clk
		.reset                  (ipsync_bridge_m0_reset_reset_bridge_in_reset_reset),                  //                     reset.reset
		.uav_address            (ipsync_bridge_m0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (ipsync_bridge_m0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (ipsync_bridge_m0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (ipsync_bridge_m0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (ipsync_bridge_m0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (ipsync_bridge_m0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (ipsync_bridge_m0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (ipsync_bridge_m0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (ipsync_bridge_m0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (ipsync_bridge_m0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (ipsync_bridge_m0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (ipsync_bridge_m0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (ipsync_bridge_m0_waitrequest),                                        //                          .waitrequest
		.av_burstcount          (ipsync_bridge_m0_burstcount),                                         //                          .burstcount
		.av_byteenable          (ipsync_bridge_m0_byteenable),                                         //                          .byteenable
		.av_read                (ipsync_bridge_m0_read),                                               //                          .read
		.av_readdata            (ipsync_bridge_m0_readdata),                                           //                          .readdata
		.av_readdatavalid       (ipsync_bridge_m0_readdatavalid),                                      //                          .readdatavalid
		.av_write               (ipsync_bridge_m0_write),                                              //                          .write
		.av_writedata           (ipsync_bridge_m0_writedata),                                          //                          .writedata
		.av_debugaccess         (ipsync_bridge_m0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer  (1'b0),                                                                //               (terminated)
		.av_begintransfer       (1'b0),                                                                //               (terminated)
		.av_chipselect          (1'b0),                                                                //               (terminated)
		.av_lock                (1'b0),                                                                //               (terminated)
		.uav_clken              (),                                                                    //               (terminated)
		.av_clken               (1'b1),                                                                //               (terminated)
		.uav_response           (2'b00),                                                               //               (terminated)
		.av_response            (),                                                                    //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                //               (terminated)
		.av_writeresponsevalid  ()                                                                     //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (8),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (10),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) ip_sync_avalon_slave_translator (
		.clk                    (shell_pll_outclk1_clk),                                               //                      clk.clk
		.reset                  (ipsync_bridge_m0_reset_reset_bridge_in_reset_reset),                  //                    reset.reset
		.uav_address            (ipsync_bridge_m0_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (ipsync_bridge_m0_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (ipsync_bridge_m0_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (ipsync_bridge_m0_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (ipsync_bridge_m0_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (ipsync_bridge_m0_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (ipsync_bridge_m0_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (ipsync_bridge_m0_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (ipsync_bridge_m0_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (ipsync_bridge_m0_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (ipsync_bridge_m0_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (ip_sync_avalon_slave_address),                                        //      avalon_anti_slave_0.address
		.av_write               (ip_sync_avalon_slave_write),                                          //                         .write
		.av_read                (ip_sync_avalon_slave_read),                                           //                         .read
		.av_readdata            (ip_sync_avalon_slave_readdata),                                       //                         .readdata
		.av_writedata           (ip_sync_avalon_slave_writedata),                                      //                         .writedata
		.av_burstcount          (ip_sync_avalon_slave_burstcount),                                     //                         .burstcount
		.av_byteenable          (ip_sync_avalon_slave_byteenable),                                     //                         .byteenable
		.av_readdatavalid       (ip_sync_avalon_slave_readdatavalid),                                  //                         .readdatavalid
		.av_waitrequest         (ip_sync_avalon_slave_waitrequest),                                    //                         .waitrequest
		.av_begintransfer       (),                                                                    //              (terminated)
		.av_beginbursttransfer  (),                                                                    //              (terminated)
		.av_writebyteenable     (),                                                                    //              (terminated)
		.av_lock                (),                                                                    //              (terminated)
		.av_chipselect          (),                                                                    //              (terminated)
		.av_clken               (),                                                                    //              (terminated)
		.uav_clken              (1'b0),                                                                //              (terminated)
		.av_debugaccess         (),                                                                    //              (terminated)
		.av_outputenable        (),                                                                    //              (terminated)
		.uav_response           (),                                                                    //              (terminated)
		.av_response            (2'b00),                                                               //              (terminated)
		.uav_writeresponsevalid (),                                                                    //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                 //              (terminated)
	);

endmodule
