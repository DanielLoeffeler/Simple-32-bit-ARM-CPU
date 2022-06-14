module Test_registerbank;
	reg [31:0] i_load;
	reg [3:0] i_dest, i_R1, i_R2;
	reg clock;
	wire [31:0] o_R1, o_R2;

	initial
	begin
			i_dest=0; i_load=32'hAAAA; i_R1=15; i_R2=0; clock=1;
		#10 i_dest=1; i_load=32'hAAAB; 
		#10 i_dest=2; i_load=32'hAAAC;
		#10 i_dest=3; i_load=32'hAAAD;
		#10 i_dest=4; i_load=32'hAAAE; 
		#10 i_dest=5; i_load=32'hAAAF;
		#10 i_dest=6; i_load=32'hAABA;
		#10 i_dest=7; i_load=32'hAABB;
		#10 i_dest=6; i_load=1'bx;
		#10 i_dest=7; i_load=32'bx;
		#10 i_R1=1; i_R2=0;
		#10 i_R1=3; i_R2=2;
		#10 i_R1=5; i_R2=4;
		#10 i_R1=7; i_R2=6;
		#10 i_R1=9; i_R2=8;
	end
	
	always #5 clock=~clock;
	
	initial
	begin
	$monitor($time," dest=%d, load=%h, S1add=%d, S2add=%d, Source1=%h, Source2=%h, flag=%b \n", i_dest, i_load, i_R2, i_R1, o_R2, o_R1,RegisterMem.flag);
	//~ " R0=%h, R1=%h, R2=%h, R3=%h, R4=%h, R5=%h, R6=%h, R7=%h, R8=%h, R9=%h, R10=%h, R11=%h, R12=%h, R13=%h, R14=%h, R15=%h \n", RegisterMem.R0, RegisterMem.R1, RegisterMem.R2, RegisterMem.R3, RegisterMem.R4, RegisterMem.R5, RegisterMem.R6, RegisterMem.R7, RegisterMem.R8, RegisterMem.R9, RegisterMem.R10, RegisterMem.R11, RegisterMem.R12, RegisterMem.R13, RegisterMem.R14, RegisterMem.R15);
	end
	
	RegisterBank RegisterMem(clock, i_dest, i_R1, i_R2, i_load, o_R1, o_R2);
							//(Clk, i_dest, i_R1, i_R2, i_load, o_R1, o_R2)
endmodule
