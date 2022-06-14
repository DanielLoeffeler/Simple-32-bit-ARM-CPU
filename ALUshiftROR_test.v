module Test_ShiftROR;
	parameter N = 4;

	reg [N-1:0] s2;
	reg [4:0] shiftamt;
	reg [2:0] srcon;
	
	wire [N-1:0] out;
	
	initial
	begin
			s2=4; shiftamt=1; srcon=3'b001;
		#10 srcon=3'b010;
		#10 srcon=3'b011;
		#10 srcon=3'b101;
	end
	
	initial
	begin
	$monitor($time," in=%b, shiftamt=%d, srcon=%b, out=%b", s2,shiftamt,srcon,out);
	end
	
	ShiftROR shift(s2, shiftamt, srcon, out);
endmodule
