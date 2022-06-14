module Test_ALU;
	reg [31:0] in1, in2; //i_in1 is source2, i_in2 is source1
	reg [15:0] imval;
	reg [4:0] shiftamt;
	reg [3:0] Cond, OP;
	reg [2:0] SRcon;
	reg Clk, S, instc;
	
	wire [31:0] result; 
	wire [7:0] program_counter;
	wire [3:0] flags; //N,Z,C,V
	
	
	initial 
	begin
			Cond=0; OP=4'b0000; in1=7; in2=4; S=0; SRcon=0; imval=0; Clk=1;
		#10 OP = 4'b0001;
		#10 OP = 4'b0010; instc=1;
		#10 OP = 4'b0011;
		#10 OP = 4'b0100;
		#10 OP = 4'b0101; imval=5'b10000;
		#10 OP = 4'b0110; 
		#10 OP = 4'b0111; instc=1;
		#10 OP = 4'b1000;
		#10 S = 1'b1;
		#10 in1 = 10; in2 = 5;
		#10 in1 = 5; in2 = 10;
		#10 OP = 0001; in1 = 4; in2 = 7; 
		#10 in1 = 7; in2 = 4;
		#10 OP = 4'b0000; Cond=4'b0010; in1=10; in2=5;
		#10 in1=3; in2=7;
		#10 Cond=4'b0011;
		#10 Cond=0; S=0; in2=1;
		#10 in1 = 32'b00001111000000000000111100000000; shiftamt = 4; SRcon = 3'b001;
		#10 SRcon = 3'b010;
		#10 in2 = 10; SRcon = 3'b011;
			//~ Cond=0; OP=4'b0110; S=0; imval=4; instc=1;
		//~ #10 OP=1000; in1=3; in2=8;
		//~ #10 Cond=4'b0010; OP=4'b0000; 
			//~ Cond=4'b0011; OP=4'b0010; in1=15; in2=2; SRcon=3'b001; shiftamt=1; Clk=1; imval=0;
		//~ #10 Cond=4'b0010;
	end

	always #5 Clk=~Clk;

	initial
	begin
	$monitor($time," Cond=%b, OP=%b, Shift=%b, S=%b, in1=%d, in2=%d, result=%d, flag=%b, prog_count=%d", Cond,OP,SRcon,S,in1,in2,result,flags,program_counter);
	end
	
	ALU alu(Clk, Cond, OP, S, instc, SRcon, in1, in2, shiftamt, imval, result, program_counter, flags); 
		   //(Clk, Cond, OP, S, instrc, SRcon, i_in1, i_in2, i_shiftamt, i_imval, o_result, o_programcounter, o_Conflags)
endmodule
