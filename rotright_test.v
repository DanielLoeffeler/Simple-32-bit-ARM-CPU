module Test_Rrotate;
	parameter N=32;
	
	reg [N-1:0] in1, rotate;
	wire [N-1:0] out;
	
	initial
	begin
			in1=15; rotate=4;
		#10 in1=231; rotate=3;
		#10 in1=986890; rotate=16;
	end
	
	initial
	begin
	$monitor($time, " input=%b, shift=%d, out=%b", in1, rotate, out);
	end
	
	NRotRight #(N) shtest (in1, rotate, out);
endmodule

