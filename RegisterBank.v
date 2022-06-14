module RegisterBank(Clk, i_dest, i_R1, i_R2, i_load, o_R1, o_R2);
	input [31:0] i_load; // info to store in destination register
	input [3:0] i_dest, i_R1, i_R2; //i_dest is destination register, i_R1 is source1, i_R2 is source2
	input Clk;
	
	output [31:0] o_R1, o_R2; //o_R1 is source1, o_R2 is source2
	
	reg [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;
	reg [15:0] o_en;
	reg flag;

	//Dec4x16 Decoder4x16(i_dest, en);
	
	always @(posedge Clk)
	begin
		#1
		//having the decoder called as a module made the timing wrong
		//because it made two always block happening concurrently rather
		//than sequentially so en was not ready in time for register
		//selection and i didn't know how to fix it so i put it herez

		case(i_dest)
			4'b0000: o_en = 16'b0000000000000001;
			4'b0001: o_en = 16'b0000000000000010;
			4'b0010: o_en = 16'b0000000000000100;
			4'b0011: o_en = 16'b0000000000001000;
			4'b0100: o_en = 16'b0000000000010000;
			4'b0101: o_en = 16'b0000000000100000;
			4'b0110: o_en = 16'b0000000001000000;
			4'b0111: o_en = 16'b0000000010000000;
			4'b1000: o_en = 16'b0000000100000000;
			4'b1001: o_en = 16'b0000001000000000;
			4'b1010: o_en = 16'b0000010000000000;
			4'b1011: o_en = 16'b0000100000000000;
			4'b1100: o_en = 16'b0001000000000000;
			4'b1101: o_en = 16'b0010000000000000;
			4'b1110: o_en = 16'b0100000000000000;
			4'b1111: o_en = 16'b1000000000000000;
			default: o_en = 16'b0000000000000000;
		endcase
		
		// register bank gets updated with a new destination register 
		//before i_load gets updated so it loads the old value of i_load 
		//but normally the new value of i_load will overwrite that wrong 
		//one but if i_load is x it doesn't get loaded in to overwrite
		// because of checks for if there are times when we don't want to load into registers.
		//Added delay forces registers to wait until ALU and everything is done
		//before updating anything 
			
		case (i_load)
			32'bx:o_en=0;
			32'bz:o_en=0;
			default: o_en=o_en;
		endcase

		case(o_en)
			16'b0000000000000001: R0 = i_load;
			16'b0000000000000010: R1 = i_load;
			16'b0000000000000100: R2 = i_load;
			16'b0000000000001000: R3 = i_load;
			16'b0000000000010000: R4 = i_load;
			16'b0000000000100000: R5 = i_load;
			16'b0000000001000000: R6 = i_load;
			16'b0000000010000000: R7 = i_load;
			16'b0000000100000000: R8 = i_load;
			16'b0000001000000000: R9 = i_load;
			16'b0000010000000000: R10 = i_load;
			16'b0000100000000000: R11 = i_load;
			16'b0001000000000000: R12 = i_load;
			16'b0010000000000000: R13 = i_load;
			16'b0100000000000000: R14 = i_load;
			16'b1000000000000000: R15 = i_load;
			default: R0=R0;
		endcase
	end
	
	MPEX16x1 MPEXS1(i_R1, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, o_R1);
	MPEX16x1 MPEXS2(i_R2, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, o_R2);
	
endmodule
