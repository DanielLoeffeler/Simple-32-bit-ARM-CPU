module NMultiplier(i_x, i_y, o_result);
	parameter N = 4;
	
	input [N-1:0] i_x, i_y;
	output [N-1:0] o_result;
	
	assign o_result=i_x*i_y;
endmodule
