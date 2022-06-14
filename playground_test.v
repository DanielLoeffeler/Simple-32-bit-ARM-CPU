module Test_play;
	parameter N=16;
	
	reg [N-1:0] s1,s2;
	reg [4:0] shiftb;
	reg [2:0] srcon;
	reg cf;
	wire [N-1:0] out,shifted;
	wire [7:0] count;
	
	initial
	begin
			s1=16; s2=16; shiftb=0; srcon=0; cf=1;
		#10 shiftb=2;
		#10 srcon=3'b001;
		#10 srcon=3'b010;
		#10 srcon=3'b011;
		#10 shiftb=4; srcon=3'b001;
		#10	shiftb=6;
		#10 ;
		#10 ;
		#10 ;
	end 
	
	initial
	begin
	$monitor($time, " s1=%b, s2=%b, srcon=%b; shiftb=%d, shifted=%b out=%d, count=%d ", s1,s2,srcon, shiftb, play.shror, out, count);
	end
	
	playground #(N) play(s1,s2,shiftb,srcon,out,shifted,cf, count);
endmodule
