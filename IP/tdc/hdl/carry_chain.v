module carry_chain
#(
	parameter          N = 256,
	parameter TECHNOLOGY = "28nm")
(	
	input wire
		clk,
		reset,
		val_in,
	input wire [N-1:0] 
		a, 
		b,
	input wire
		cin,
	output wire [N-1:0]
		s,
	output wire
		cout,
	output reg
		val_out
);
		
	wire [N-1:0] s_int;
	wire [N-1:0] s_buff;
	wire [N-1:0] c_int;
	wire [N-1:0] c_buff;
	
	// Only Aria 10 requires sharein/shareout for ALM
	//		in arithmetic mode
	wire [N:0] share_intercon;
	
	genvar i;
	
	wire vcc, gnd;
	assign {vcc, gnd} = 2'b10;
	
	// Pipeline val to match first sync stage
	always@(posedge clk) begin
		if(reset) begin
			val_out <= 1'b0;
		end else begin
			val_out <= val_in;
		end
	end
	
	// 2 of the 4 LUTs are specified per lcell_comb
	// 	upper LUT passes C, lower passes D
	//		note - LUT mask logic is inverted!
	generate
		case(TECHNOLOGY)
		"10nm":
			tennm_lcell_comb
			#(
				.lut_mask(64'h00000000000F0FF0),
				.dont_touch("off"),
				.shared_arith("off"),
				.extended_lut("off")
			)
			lcell_0
			(
				.dataa(gnd),
				.datab(gnd),
				.datac(~a[0]),
				.datad(~b[0]),
				.cin(cin),
				.sumout(s_int[0]),
				.cout(c_int[0])
			) /* synthesis keep */;
		"14nm":
			fourteennm_lcell_comb
			#(
				.lut_mask(64'h00000000000F0FF0),
				.dont_touch("off"),
				.shared_arith("off"),
				.extended_lut("off")
			)
			lcell_0
			(
				.dataa(gnd),
				.datab(gnd),
				.datac(~a[0]),
				.datad(~b[0]),
				.cin(cin),
				.sumout(s_int[0]),
				.cout(c_int[0])
			);
			
		"20nm":
			twentynm_lcell_comb
			#(
				.lut_mask(64'h0000033F00003CC3),
				.dont_touch("off"),
				.shared_arith("off"),
				.extended_lut("off")
			)
			lcell_0
			(
				.dataa(gnd),
				.datab(~cin),
				.datac(~a[0]),
				.datad(~b[0]),
				.cin(gnd),
				.sumout(s_int[0]),
				.cout(c_int[0]),
				.sharein(gnd),
				.shareout(share_intercon[0])
			) /* synthesis keep */;
		"28nm":
			cyclonev_lcell_comb 
			#(
				.extended_lut("off"),
			  .lut_mask(64'h0000FF0000003333),
			  .shared_arith("off")
			 ) 
			 lcell_0
			 (
				.dataa(gnd),
				.datab(~a[0]),
				.datac(gnd),
				.datad(gnd),
				.datae(gnd),
				.dataf(~b[0]),
				.datag(gnd),
				.cin(gnd),
				.sharein(gnd),
				.combout(),
				.sumout(s_int[0]),
				.cout(c_int[0]),
				.shareout());
		endcase
	endgenerate
	
	// Generate loop to create chain
	// 	carry chain must start at node 0 in a LAB!
	generate
		for (i = 1; i<N; i=i+1) begin : gen_reg_cc
			carry_sum
			csi 
			(
				.sin(s_int[i-1]), 
				.cin(c_int[i-1]),
				.sout(s_buff[i-1]), 
				.cout(c_buff[i-1])
			);
			case(TECHNOLOGY)
			"10nm":
				tennm_ff 
				#(
					.is_wysiwyg("false"),
					.dont_touch("off")
				)
				reg_i 
				(
					.clk(clk),
					.d(s_buff[i-1]),	
					.asdata(vcc),
					.clrn(vcc),		
					.aload(gnd),
					.sclr(gnd),
					.sload(gnd),
					.ena(vcc),
					.sclr1(gnd),
					.q(s[i-1])
				);
			"14nm":
				fourteennm_ff 
				#(
					.is_wysiwyg("false"),
					.dont_touch("off")
				)
				reg_i
				(
					.clk(clk),
					.d(s_buff[i-1]),	
					.asdata(vcc),
					.clrn(vcc),		
					.aload(gnd),
					.sclr(gnd),
					.sload(gnd),
					.ena(vcc),
					.sclr1(gnd),
					.q(s[i-1])
				);
			"20nm":
				twentynm_ff 
				#(
					.is_wysiwyg("false"),
					.dont_touch("off")
				)
				reg_i 
				(
					.clk(clk),
					.d(s_buff[i-1]),	
					.asdata(vcc),
					.clrn(vcc),		
					.aload(gnd),
					.sclr(gnd),
					.sload(gnd),
					.ena(vcc),
					.sclr1(gnd),
					.q(s[i-1])
				);
			"28nm":
				dffeas 
				#(
					.is_wysiwyg("true")
				 ) 
				 reg_i 
				 (
					.clk(clk),
					.d(s_buff[i-1]),
					.asdata(vcc),
					.clrn(vcc),
					.aload(gnd),
					.sclr(gnd),
					.sload(gnd),
					.ena(vcc),
					.q(s[i-1] ));
			endcase
		
			case(TECHNOLOGY)
			
			"10nm":
				tennm_lcell_comb
				#(
					.lut_mask(64'h00000000000F0FF0),
					.dont_touch("off"),
					.shared_arith("off"),
					.extended_lut("off")
				)
				lcell_i
				(
					.dataa(gnd),
					.datab(gnd),
					.datac(~a[i]),
					.datad(~b[i]),
					.cin(c_buff[i-1]),
					.sumout(s_int[i]),
					.cout(c_int[i])
				);
			
			"14nm":
				fourteennm_lcell_comb
				#(
					.lut_mask(64'h00000000000F0FF0),
					.dont_touch("off"),
					.shared_arith("off"),
					.extended_lut("off")
				)
				lcell_i
				(
					.dataa(gnd),
					.datab(gnd),
					.datac(~a[i]),
					.datad(~b[i]),
					.cin(c_buff[i-1]),
					.sumout(s_int[i]),
					.cout(c_int[i])
				);
			
			"20nm":
				twentynm_lcell_comb
				#(
					.lut_mask(64'h0000000F00000FF0),
					.dont_touch("off"),
					.shared_arith("on"),
					.extended_lut("off")
				)
				lcell_i
				(
					.dataa(gnd),
					.datab(gnd),
					.datac(~a[i]),
					.datad(~b[i]),
					.cin(c_buff[i-1]),
					.sumout(s_int[i]),
					.cout(c_int[i]),
					.sharein(share_intercon[i-1]),
					.shareout(share_intercon[i])
				);
			"28nm":
				cyclonev_lcell_comb 
				#(
					.extended_lut("off"),
				  .lut_mask(64'h0000FF0000003333),
				  .shared_arith("off")
				 ) 
				 lcell_i
				 (
					.dataa(gnd),
					.datab(~a[i]),
					.datac(gnd),
					.datad(gnd),
					.datae(gnd),
					.dataf(~b[i]),
					.datag(gnd),
					.cin(c_buff[i-1]),
					.sharein(gnd),
					.sumout(s_int[i]),
					.cout(c_int[i]),
					.shareout());	
			endcase
		end
	endgenerate
	
	carry_sum
	csi 
	(
		.sin(s_int[N-1]), 
		.cin(c_int[N-1]),
		.sout(s_buff[N-1]), 
		.cout(c_buff[N-1])
	);
	
	// Generate last FF
	generate
		case(TECHNOLOGY)
		
		"10nm":
			tennm_ff 
			#(
				.is_wysiwyg("false"),
				.dont_touch("off")
			)
			reg_last  
			(
				.clk(clk),
				.d(s_buff[N-1]),	
				.asdata(vcc),
				.clrn(vcc),		
				.aload(gnd),
				.sclr(gnd),
				.sload(gnd),
				.ena(vcc),
				.sclr1(gnd),
				.q(s[N-1])
			);
		
		"14nm":
			fourteennm_ff 
			#(
				.is_wysiwyg("false"),
				.dont_touch("off")
			)
			reg_last  
			(
				.clk(clk),
				.d(s_int[N-1]),	
				.asdata(vcc),
				.clrn(vcc),		
				.aload(gnd),
				.sclr(gnd),
				.sload(gnd),
				.ena(vcc),
				.sclr1(gnd),
				.q(s[N-1])
			);
		
		"20nm":
			twentynm_ff 
			#(
				.is_wysiwyg("false"),
				.dont_touch("off")
			)
			reg_last  
			(
				.clk(clk),
				.d(s_int[N-1]),	
				.asdata(vcc),
				.clrn(vcc),		
				.aload(gnd),
				.sclr(gnd),
				.sload(gnd),
				.ena(vcc),
				.sclr1(gnd),
				.q(s[N-1])
			);
		"28nm":
			dffeas 
			#(
				.is_wysiwyg("true")
			 ) 
			 reg_last 
			 (
				.clk(clk),
				.d(s_int[N-1]),
				.asdata(vcc),
				.clrn(vcc),
				.aload(gnd),
				.sclr(gnd),
				.sload(gnd),
				.ena(vcc),
				.q(s[N-1]));
		endcase
	endgenerate
		
	assign cout = c_buff[N-1];
	
endmodule
