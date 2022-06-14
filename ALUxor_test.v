module BitWiseXor_Test;
	parameter N = 32;
	
	reg [N-1:0] in1,in2;
	wire [N-1:0] out;
	
	initial
	begin
			in1=4'b0010; in2=4'b0001;
		#10 in1=4'b0010; in2=4'b0010;
		#10 in1=4'b1111; in2=4'b0101;
		#10 in1=32'b01010101010101010101010101010101; in2=32'b11110010001000100010001000101111;
	end
	
	initial
	begin
	$monitor($time, " num1=%b, num2=%b, result=%b", in1,in2,out);
	end
	
	BitWiseXor #(N) Tand(in1,in2,out);
endmodule


