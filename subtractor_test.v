module Test_Subtractor;
	parameter N=32;
	
	reg [N-1:0] in1, in2;
	reg Bin;
	
	wire [N-1:0] Diff;
	wire Bout, Vout;
	
	initial
	begin
			in1=10; in2=5; Bin=0;
		#10 in1=8; in2=3;
		#10 in1=15; in2=15;
		#10 in1=32'b11111111111111111111111111111111; in2=32'b11111111111111111111111111111110;
		#10 in1=32'b11111111111111111111111111111111; in2=32'b1111111111111111111111111111111;
		#10 in1=32'b1111111111111111111111111111111; in2=32'b11111111111111111111111111111111;
		#10 in1=10; in2=5; Bin=1;
	end
	
	initial
	begin
	$monitor($time, " num1=%d, num2=%d, difference=%d, Bin=%b, Bout=%b, V=%b", in1,in2,Diff,Bin,Bout,Vout);
	end

	NSubtractor #(N) Tsub(in1, in2, Bin, Diff, Bout, Vout);
endmodule


