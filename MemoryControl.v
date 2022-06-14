module MemControl(OP, i_in1, i_in2, i_databus, i_ALU, o_databus, o_RW, o_regdat, o_ramaddr);
	
	//in1 is source1, in2 is source2, i_databus is data coming in from the databus
	//i_ALU is data in from the ALU
	input [31:0] i_in1, i_in2, i_databus, i_ALU; 
	input [3:0] OP; //Operation code
	
	//o_regdat is data to be stored in a register, o_databus is data going out on the databus, o_ramaddr is a ram address for str or ldr
	output [31:0] o_regdat, o_databus;
	output [3:0] o_ramaddr;
	output [1:0] o_RW; //LDR is RW=2'b01 STR is RW=2'b10
	
	assign o_RW[0] = (OP==4'b1001)?1'b1:1'b0; //if LDR
	assign o_RW[1] = (OP==4'b1010)?1'b1:1'b0; //if STR
	
	assign o_ramaddr = (o_RW)? i_in1[3:0]: 32'bx; //Source1 is register holding ram address
	assign o_databus = i_in2; //Source2 is register holding data to store in ram
	
	assign o_regdat = (o_RW[0])? i_databus: i_ALU; //sel to LDR MUX
	//assign o_ramaddr = (o_RW)?1'b1:1'b0; //sel to Add. Bus MUX
	
endmodule
	
	
