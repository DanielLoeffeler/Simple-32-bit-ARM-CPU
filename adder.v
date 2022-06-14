module HA (i_X, i_Y, o_S, o_C);
	input i_X,i_Y;
	output o_S,o_C;

	xor x1(o_S, i_X, i_Y);
	and a1(o_C, i_X, i_Y);
endmodule

module FA(i_X, i_Y, i_Cin, o_S, o_Co);
	input i_X, i_Y, i_Cin;
	output o_S, o_Co;
	wire w1, w2, w3;
	
	HA h1(i_X, i_Y, w1, w2);
	HA h2(w1, i_Cin, o_S, w3);
	or o1(o_Co, w2, w3);
endmodule

module NAdder (i_x, i_y, i_cin, o_sum, o_cout, o_V);
	// paramaterized adder that instantiated FA until N bit adder 
	parameter N = 4; // defines bits of adder
	input [N-1:0] i_x, i_y;
	input i_cin;
	
	output [N-1:0] o_sum;
	output o_cout, o_V; //o_V is overflow
	
	wire [N:0] C;
	
	assign C[0] = i_cin;
	
	genvar i;
	generate
	for (i=0; i<N; i=i+1)
		begin
			FA Full(i_x[i], i_y[i], C[i], o_sum[i], C[i+1]);
		end
	endgenerate
	
	assign o_cout=C[N];
	//if the sign of the two inputs is equal and the sign of the result is different from them, then overflow happened
	assign o_V=(i_x[N-1]==i_y[N-1])?((o_sum[N-1]!=i_x[N-1])?1:0):0; 
endmodule
