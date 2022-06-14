module MPEX16x1(i_sel,i_R0,i_R1,i_R2,i_R3,i_R4,i_R5,i_R6,i_R7,i_R8,i_R9,i_R10,i_R11,i_R12,i_R13,i_R14,i_R15,o_out);
	input [3:0] i_sel;
	input [31:0] i_R0,i_R1,i_R2,i_R3,i_R4,i_R5,i_R6,i_R7,i_R8,i_R9,i_R10,i_R11,i_R12,i_R13,i_R14,i_R15;
	
	output reg [31:0] o_out;
	
	always@(*)
	begin
	case(i_sel)
		4'b0000: o_out = i_R0;
		4'b0001: o_out = i_R1;
		4'b0010: o_out = i_R2;
		4'b0011: o_out = i_R3;
		4'b0100: o_out = i_R4;
		4'b0101: o_out = i_R5;
		4'b0110: o_out = i_R6;
		4'b0111: o_out = i_R7;
		4'b1000: o_out = i_R8;
		4'b1001: o_out = i_R9;
		4'b1010: o_out = i_R10;
		4'b1011: o_out = i_R11;
		4'b1100: o_out = i_R12;
		4'b1101: o_out = i_R13;
		4'b1110: o_out = i_R14;
		4'b1111: o_out = i_R15;
		default: o_out = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	endcase
	end
endmodule
