module Control;
	wire [31:0] ist; //Instruction line fetched from RAM

	reg [15:0] ImVal; //Immediate Value instruction
	reg [4:0] Shiftamt; //Shift ROR bits to ALU
	reg [3:0] Cond, OP, DestR, R1, R2; //Address of Destination(DestR), R1,and R2 
	reg [2:0] SRcon; //Shift rotate control
	reg clock, S, instrc; //ALU flag enable, instruction counter count enable
	
	wire [31:0] Source1, Source2, RegisterMemIn, ALUResult; //Data at R1 and R2, Data to be stored in the registers, Result from ALU
	wire [31:0] memin_ramdatabus, ramin_ramdatabus; //Databus between RAM and memcontrol
	wire [7:0] programcounter; //Program counter from ALU
	wire [3:0] ramaddr, ALUFlags; //Address to RAM from memcontrol, condition flags from ALU
	wire [1:0] RW; //Read write signals to RAM from memcontrol
	
	initial
	begin
			$readmemb("D:/verilog_projects/32'b cpu/demo_v2_c1.txt", RamMem.memory); clock=1;
			//~ $readmemb("D:/verilog_projects/32'b cpu/1LDR Instruction Set v2.txt", RamMem.memory); clock=1;
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; instrc=1;
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 Cond=ist[31:28]; OP=ist[27:24]; S=ist[23]; R1=ist[18:15]; R2=ist[14:11]; Shiftamt=ist[10:6]; ImVal=ist[18:3]; SRcon=ist[2:0]; DestR=ist[22:19]; 
		#10 $writememb("D:/verilog_projects/32'b cpu/!Rammem.txt", RamMem.memory);
	end
	
	always #5 clock=~clock;

	initial
	begin
	$monitor($time, //" Cond=%b, OP=%b, S=%b, DestR=%b, R1=%b, R2=%b, ShROR=%b, ImVal=%b, SRcon=%b, PC=%d \n", Cond,OP,S,DestR,R1,R2,Shiftamt,ImVal,SRcon,programcounter,
	//"\t\t memconRW=%b, memconregout=%d, ALUout=%d rbankEN=%b, ramdatain =%b, ramdataout=%b, ALUflags=%b, RAMaddr=%b, S1=%d, S2=%d \n", MemoryRoute.o_RW, MemoryRoute.o_regdat,ALUResult, RegisterMem.o_en, ramin_ramdatabus, memin_ramdatabus, ALUFlags, ramaddr, Source1, Source2,
" R0=%d, R1=%d, R2=%d, R3=%d, R4=%d, R5=%d, R6=%d, R7=%d, R8=%d, R9=%d, R10=%d, R11=%d, \n \t\t      R12=%d, R13=%d, R14=%d, R15=%d, ALUflags=%b \n", RegisterMem.R0, RegisterMem.R1, RegisterMem.R2, RegisterMem.R3, RegisterMem.R4, RegisterMem.R5, RegisterMem.R6, RegisterMem.R7, RegisterMem.R8, RegisterMem.R9, RegisterMem.R10, RegisterMem.R11, RegisterMem.R12, RegisterMem.R13, RegisterMem.R14, RegisterMem.R15, ALUFlags);
	end

	ALU alu(clock, Cond, OP, S, instrc, SRcon, Source1, Source2, Shiftamt, ImVal, ALUResult, programcounter, ALUFlags);
		 // (Clk,  Cond, OP, S, instrc, SRcon, i_in1,    i_in2, i_shiftamt, i_imval, o_result, o_programcounter, o_Conflags);
	   
	MemControl MemoryRoute(OP, Source1, Source2, memin_ramdatabus, ALUResult, ramin_ramdatabus, RW, RegisterMemIn, ramaddr);
						  //(i_in1, i_in2,  i_databus, 			i_ALU,  	o_databus, 		o_RW, o_regdat,   o_ramaddr)
						  
	RAM RamMem(clock, ramaddr, RW, ramin_ramdatabus, programcounter, memin_ramdatabus, ist);
			 //(Clk, i_ramaddr, i_RW, i_databus,  	i_PC, 			o_databus,   o_instrfetch);
			  
	RegisterBank RegisterMem(clock, DestR, R1, R2, RegisterMemIn, Source1, Source2);
						  //(Clk,  i_dest, i_R1, i_R2, i_load,		o_R1,  o_R2);
endmodule
