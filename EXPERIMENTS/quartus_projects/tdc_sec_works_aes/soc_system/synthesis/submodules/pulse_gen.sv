module pulse_gen
(
	input logic clk, reset,
	output logic  pulse
);
	
	logic [1:0] count;
	
	always_comb pulse = count[1];
	
	always_ff@(posedge clk)
		if(reset)
			count <= 2'b0;
		else
			count <= count + 2'b1;
	
endmodule
