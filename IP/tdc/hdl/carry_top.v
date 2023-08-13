module carry_top
	#(
		parameter C_OUT_WIDTH  = 256,
		parameter C_SYNC_DEPTH = 2,
		parameter TECHNOLOGY   = "28nm"
	)(
		// Globals
		input                    	clk, rst,

		// S AVST
		input  [7:0]      			S_AVST_DATA,
		input 						S_AVST_VALID,

		// M AVST
		output [C_OUT_WIDTH-1:0] 	M_AVST_DATA,
		output                   	M_AVST_VALID
	);

	// Inputs - keep ensures LCELL boundary
	wire [C_OUT_WIDTH-1:0]
		wInputB /* synthesis keep */;
	wire [C_OUT_WIDTH-1:0]    
		wInputA /* synthesis keep */;
	
	// Input to chain is 'h0_FFFF_FFFF_FFFF_FFFF... + input
	assign wInputB 
		= {C_OUT_WIDTH{1'b1}};
	assign wInputA 
		= {{C_OUT_WIDTH-1{1'b0}}, S_AVST_DATA[0]};
	
	// Keep carry out to guarantee carry chain length
	wire 
		wCarryOut;

	// Wire to capture output result
	wire [C_OUT_WIDTH:0]
		wResult /* synthesis keep */;
	
	// Sync registers
	reg [C_OUT_WIDTH-1:0]
		rSync [0:C_SYNC_DEPTH] /* synthesis preserve */;

	reg [C_SYNC_DEPTH:0]
		rSyncValid /* synthesis preserve */;
	
	// Chain registers output so valid delayed 1 pipe stage
	wire 
		rSyncValOut;
	
	// At least 2 sync stages
	always @(posedge clk) begin
          rSync[0]      <= rst ? {C_OUT_WIDTH{1'b0}} : wResult[C_OUT_WIDTH-1:0];
		  rSyncValid[0] <= rst ? 1'b0 : rSyncValOut;
   	end
	
	genvar i;
	// Add additional sync depth if specified
	generate 
		for(i = 0; i < C_SYNC_DEPTH; i = i + 1) begin : syncgen
			always @(posedge clk) begin
				rSync[i+1]      <= rst ? {C_OUT_WIDTH{1'b0}} : rSync[i];
				rSyncValid[i+1] <= rst ? 1'b0 : rSyncValid[i];
			end
		end
	endgenerate

	assign M_AVST_DATA
		= rSync[C_SYNC_DEPTH];
	
	// Detect rising edge of output TVALID (set at same clock that the output sample is ready)
	assign M_AVST_VALID
		= rSyncValid[C_SYNC_DEPTH];

	carry_chain 
	#(
		.N(C_OUT_WIDTH),
		.TECHNOLOGY(TECHNOLOGY))
	cc
	(
		.clk(clk),
		.reset(rst),
		.a(wInputA), 
		.b(wInputB),
		.cin(1'b0),
		.s(wResult[C_OUT_WIDTH-1:0]),
		.cout(wCarryOut),
		.val_in(S_AVST_VALID),
		.val_out(rSyncValOut)
	);

	assign wResult[C_OUT_WIDTH] = wCarryOut;
	 
endmodule
