module Test_Nmult;
	parameter N=32;
	
	reg [N-1:0] in1,in2;
	wire [N-1:0] out;
	
	initial
	begin
			in1=2; in2=3; 
		#10 in1=1; in2=3;
		#10 in1=25; in2=3;
		#10 in1=4000; in2=5;
		#10 in1=2147483648; in2=2;
	end
	
	initial
	begin
	$monitor($time, " num1=%d, num2=%d, result=%d", in1,in2,out);
	end
	
	NMultiplier #(N) mul(in1, in2, out);
endmodule
