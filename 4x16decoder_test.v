module Dec4x16_test;
	reg [3:0] sel;
	wire [15:0] out;
	
	initial
	begin
			sel=0;
		#10 sel=1;
		#10 sel=2;
		#10 sel=3;
		#10 sel=4;
		#10 sel=5;
		#10 sel=6;
		#10 sel=7;
		#10 sel=8;
		#10 sel=9;
		#10 sel=10;
		#10 sel=11;
		#10 sel=12;
		#10 sel=13;
		#10 sel=14;
		#10 sel=15;
	end
	
	initial
	begin
	$monitor($time, " sel=%d, out=%b", sel, out);
	end
	
	Dec4x16 memdec(sel,out);
endmodule

