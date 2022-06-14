module ShiftROR (i_s2, i_shiftbit, i_srcon, o_out);
	parameter N=4;
	
	input [N-1:0] i_s2;
	input [4:0] i_shiftbit;
	input [2:0] i_srcon;
	
	output [N-1:0] o_out;
	
	wire [N-1:0] RSHr, LSHr, RROTr;
	
	Nshiftright #(N) rshift (i_s2, i_shiftbit, RSHr);
	Nshiftleft #(N) lshift (i_s2, i_shiftbit, LSHr);
	NRotRight #(N) rrot (i_s2, i_shiftbit, RROTr);

	assign o_out = (i_srcon==3'b001)? RSHr : ((i_srcon==3'b010)? LSHr :((i_srcon==3'b011)? RROTr : i_s2));
endmodule
