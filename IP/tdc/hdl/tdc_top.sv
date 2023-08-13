module tdc_top
	#(
		parameter C_OUT_WIDTH  = 256,
		parameter C_SYNC_DEPTH = 2,
		parameter TECHNOLOGY   = "28nm",
		parameter REVERSE      = 0
	)
	(
		// Globals
		input logic clk_launch,
					clk_capt,
				    reset,

		// AXI-S interface to pulse generator
		output logic 				   S_AVST_READY,
		input logic  [  7:0]           S_AVST_DATA,
    	input logic 		           S_AVST_VALID,

		// AV-ST interface to DC FIFO 
		output logic	               M_AVST_VALID,
		output logic [255:0]           M_AVST_DATA,
		input logic 			 	   M_AVST_READY
	);
	
	logic tdc_valid_out;
	logic [C_OUT_WIDTH-1:0] tdc_data_out;

	logic tdc_valid;
	// C_OUT_WIDTH must evenly divide 256-bit DMA bus
	logic [(256/C_OUT_WIDTH)-1:0][C_OUT_WIDTH-1:0]
		tdc_data;
	logic [$clog2(256/C_OUT_WIDTH)-1:0]
		idx_count;

	// TDC data packing logic
	always_ff@(posedge clk_capt) begin
		if(reset) begin
			idx_count   <= '0;
			tdc_valid   <= 1'b0;
		end else if(tdc_valid_out) begin
			if(idx_count == ((256/C_OUT_WIDTH)-1)) begin
				idx_count <= '0;
				tdc_valid <= 1'b1;
			end else begin
				idx_count <= idx_count + {{$clog2(256/C_OUT_WIDTH)-1{1'b0}}, 1'b1};
				tdc_valid <= 1'b0;
			end
		end else begin
			idx_count <= '0;
			tdc_valid <= 1'b0;
		end
	end

	// Allows data to be shifted in left or right depending on DMA/SW settings
	genvar i;
	generate
		if(REVERSE) begin
			for(i=0; i < (256/C_OUT_WIDTH); i=i+1) begin : gen_tdc_data_word
				always_ff@(posedge clk_capt) begin
					if(i == 0)
						tdc_data[0] <= reset ? '0 :
							tdc_valid_out ? tdc_data_out : tdc_data[0];
					else
						tdc_data[i] <= reset ? '0 :
							tdc_valid_out ? tdc_data[i-1] : tdc_data[i];
				end
			end
		end else begin
			for(i=(256/C_OUT_WIDTH) - 1; i >= 0; i=i-1) begin : gen_tdc_data_word
				always_ff@(posedge clk_capt) begin
					if(i == (256/C_OUT_WIDTH) - 1)
						tdc_data[(256/C_OUT_WIDTH) - 1] <= reset ? '0 :
							tdc_valid_out ? tdc_data_out : tdc_data[(256/C_OUT_WIDTH) - 1];
					else
						tdc_data[i] <= reset ? '0 :
							tdc_valid_out ? tdc_data[i+1] : tdc_data[i];
				end
			end
		end
	endgenerate

	// Pass ready signal directly to pulsegenerator
	always_ff@(posedge clk_capt)
		S_AVST_READY <= M_AVST_READY;

	always_comb M_AVST_VALID = tdc_valid;
	always_comb M_AVST_DATA  = tdc_data;

	carry_top
	#(.C_OUT_WIDTH(C_OUT_WIDTH),
	  .C_SYNC_DEPTH(C_SYNC_DEPTH),
	  .TECHNOLOGY(TECHNOLOGY)
	 )
	 carry0 
	 (
		// Globals
		clk_capt,
		reset,
		// S AVST
		S_AVST_DATA,
		S_AVST_VALID,
		// M AVST
		tdc_data_out,
		tdc_valid_out
	);
	
endmodule
