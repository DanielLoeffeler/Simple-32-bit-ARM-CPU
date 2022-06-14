module Test_ALUMover;
	reg [31:0] s2;
	reg [15:0] imval;
	
	wire [31:0] out, outim;
	
	initial 
	begin
			s2=0; imval=0;
		#10 s2=24; imval=5;
	end
	
	initial 
	begin
	$monitor($time,"  Source2=%d, Imval=%d, Out=%d, Imout=%d", s2, imval, out, outim);
	end
	
	Mover move(s2, imval, out, outim);
endmodule
