module Test_compare;
	parameter N = 32;
	reg [N-1:0] in1,in2;
	
	wire [3:0] flags;

	initial
	begin
			in1=7 ; in2=4 ;
		#10 in1=4 ; in2=7 ;
		#10 in1=7 ; in2=8 ;
		#10 in1=5 ; in2=10 ;
		#10 in1=15; in2=2;
		#10 in1=2147483648; in2=1;
		//~ #10 in1= ; in2= ;
		//~ #10 in1= ; in2= ;
		//~ #10 in1= ; in2= ;
	end
	
	initial
	begin
	$monitor($time, " in1=%d %b, in2=%d %b, N=%b, Z=%b, C=%b, V=%b", in1,in1,in2,in2,flags[3],flags[2],flags[1],flags[0]);
	end
	
	Compare #(N) cum (in1,in2,flags);
endmodule
	
