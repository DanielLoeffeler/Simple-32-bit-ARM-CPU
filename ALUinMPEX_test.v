module ALUinMPEX_test;
	reg [31:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15;
	reg [3:0] sel;
	wire [31:0] out;
	
	initial
	begin
			R0=0;R1=1;R2=2;R3=3;R4=4;R5=5;R6=6;R7=7;R8=8;R9=9;R10=10;R11=11;R12=12;R13=13;R14=14;R15=15;
		#10 sel=0;
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
	
	MPEX16x1 Tpex(sel,R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,out);
endmodule
