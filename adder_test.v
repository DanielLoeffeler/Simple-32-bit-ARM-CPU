module Test_Adder;
parameter N=32;

reg[N-1:0] in1, in2;
reg Cin;
wire[N-1:0] result;
wire Cout, Vout;

initial
begin
		in1=2; in2=3; Cin=0;
	#10 in1=1; in2=3;
	#10 in1=14; in2=1;
	#10 in1=15; in2=1;
	#10 in1=2147483647; in2=1;
	#10 in1=32'b11111111111111111111111111111111; in2=1;
end

initial
begin
$monitor($time, " num1=%d, num2=%d, sum=%b, cout=%d, V=%b", in1, in2, result, Cout, Vout);
end

NAdder #(N) add(in1, in2, Cin, result, Cout, Vout);
endmodule
