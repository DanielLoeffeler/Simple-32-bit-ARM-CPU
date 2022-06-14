module NRotRight(i_x, i_rot, o_out);
	parameter N = 4;
	
	input [N-1:0] i_x;
	input [4:0] i_rot;
	output [N-1:0] o_out;
	
	//a rotate is just an OR of logical shift left and right
	//shift left by (n bits)-(rotate amt)
	//shift right by rotate amt
	assign o_out = (i_x << (N-i_rot)) | (i_x >> i_rot);
endmodule
