module playground(s1, s2, shiftb, srcon, out, shifted, countflag, count);
	parameter N=4;
	input [N-1:0] s1,s2;
	input [4:0] shiftb;
	input [2:0] srcon;
	input countflag;
	
	output [N-1:0] out, shifted;
	output[7:0] count;
	
	wire [N-1:0] shror;
	
	ShiftROR #(N) shrorer (s2, shiftb, srcon, shror);
	NMultiplier #(N) mult (s1, shror, out);
	
	assign shifted = shror;
	assign count = (count==1'bx)? 8'b0: count;
	assign count = (countflag==1)? count+1: count;
endmodule
	
		
