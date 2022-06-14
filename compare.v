module Compare(i_in1, i_in2, o_flag);
	parameter N = 4;
	input [N-1:0] i_in1, i_in2;
	output [3:0] o_flag; // o_flag[N,Z,C,V]
	
	wire [N:0] temp;
	
	assign temp = i_in1 - i_in2;
	assign o_flag[3] = (temp[N-1])?1:0;	//if the MSB is 1 then N=1
	assign o_flag[2] = (temp[N-1:0])?0:1; //if i_in1-i_in2=0 Z=1
	assign o_flag[1] = temp[N]; //if the 33rd bit of the subtraction is 1 then there is carry 
	
	//if the sign of the two inputs is different and the sign of the result is the same as the subtrahend, then overflow happened
	assign o_flag[0] = (i_in1[N-1]!=i_in2[N-1])?((temp[N-1]==i_in2[N-1])?1:0):0; 
	
endmodule
