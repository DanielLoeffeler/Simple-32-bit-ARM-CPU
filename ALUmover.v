module Mover (i_source2, i_imval, o_out, o_outim);

	input [15:0] i_imval; //immediate value amount
	input [31:0] i_source2; //value in source2
	
	output [31:0] o_out, o_outim;
	
	assign o_out = i_source2; //move R2 into R1 OP 0111
	assign o_outim = i_imval; //move im val into R1 OP 0110
	
endmodule
