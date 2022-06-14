module BitWiseXor (i_x, i_y, o_o);
	parameter N = 4;
	input [N-1:0] i_x, i_y;
	output [N-1:0] o_o;
	
	assign o_o = i_x^i_y;
endmodule


