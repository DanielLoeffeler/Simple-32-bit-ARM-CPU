module HS (i_X, i_Y, o_D, o_B);
	input i_X, i_Y;
	output o_D, o_B;
	
	wire NX;
	
	xor xor1(o_D,i_X,i_Y);
	not not1(NX,i_X);
	and and1(o_B,i_Y,NX);
endmodule

module FS(i_X, i_Y, i_Bin, o_D, o_Bout);
	input i_X, i_Y, i_Bin;
	output o_D, o_Bout;
	
	wire wD, wB1, wB2;
	
	HS half1(i_X,i_Y,wD,wB1);
	HS half2(wD,i_Bin,o_D,wB2);
	or or2(o_Bout,wB2,wB1);
endmodule

module NSubtractor(i_X, i_Y, i_Bin, o_D, o_Bout, o_V);
	parameter N = 4;
	
	input [N-1:0] i_X, i_Y;
	input i_Bin;
	
	output [N-1:0] o_D;
	output o_Bout, o_V;//o_V is overflow
	
	wire [N:0] B;
	
	assign B[0] = i_Bin;
	
	genvar i;
	generate
	for (i=0; i<N; i=i+1)
		begin
			FS Full(i_X[i], i_Y[i], B[i], o_D[i], B[i+1]);
		end
	endgenerate
	
	assign o_Bout = B[N];
	//if the sign of the two inputs is different and the sign of the result is the same as the subtrahend, then overflow happened
	assign o_V=(i_X[N-1]!=i_Y[N-1])?((o_D[N-1]==i_Y[N-1])?1:0):0; 
endmodule

