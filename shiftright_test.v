module Test_Rshift;
	parameter N=32;
	
	reg [N-1:0] in1, shift;
	wire [N-1:0] out;
	
	initial
	begin
			in1=15; shift=3; 
		#10 in1=7; shift=2;
		#10 in1=4294967295; shift=16;
	end
	
	initial
	begin
	$monitor($time, " input=%b, shift=%d, out=%b", in1, shift, out);
	end
	
	Nshiftright #(32) shtest (in1, shift, out);
endmodule
