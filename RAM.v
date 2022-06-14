module RAM(Clk, i_ramaddr, i_RW, i_databus, i_PC, o_databus, o_instrfetch);
	input [31:0] i_databus; //input data from databus
	input [7:0] i_PC; //Program Counter input for fetching instructions
	input [3:0] i_ramaddr; //ram address to access
	input [1:0] i_RW; //Read Write signal 00 is instrfetch, 01 is LRD, 10 is STR
	input Clk;
	
	output reg [31:0] o_databus, o_instrfetch; //output databus and the instruction fetch line
	
	reg [31:0] memory [0:15]; //16 address's of 32 bit words
	
	always @(*)
	begin
		o_instrfetch = memory[i_PC]; //retrieves instruction at the program counter address 
		if(i_RW[0]) o_databus = memory[i_ramaddr]; //if LDR then load mem at address to databus
		else if(i_RW[1]) memory[i_ramaddr] = i_databus; //if STR then store from databus to address
		else o_databus = 32'bx;
	end
endmodule
	
	
