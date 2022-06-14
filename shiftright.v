module Nshiftright(i_x,i_shift,o_out);
	parameter N=4;
	
	input [N-1:0] i_x;
	input [4:0] i_shift;
	output [N-1:0] o_out;
	
	//assign o_out = {{i_shift{1'b0}},i_x[N-1:i_shift]};
	assign o_out = i_x>>i_shift;
endmodule
