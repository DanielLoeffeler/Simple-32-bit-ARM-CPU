module ALU(Clk, Cond, OP, S, instrc, SRcon, i_in1, i_in2, i_shiftamt, i_imval, o_result, o_programcounter, o_Conflags);
	input [31:0] i_in1, i_in2; //i_in1 is source1, i_in2 is source2
	input [15:0] i_imval; //immediate value input
	input [4:0] i_shiftamt; //shift ROR amount
	input [3:0] Cond, OP; //Cond is the condition code, OP is the operation code
	input [2:0] SRcon; //Shift Rotate control
	input Clk, S, instrc; //Set flags, instruction flag controls program counter
	
	output reg [31:0] o_result; 
	output reg [7:0] o_programcounter=0;
	output reg [3:0] o_Conflags; //Flags set after operation
	
	reg flag; //When a conditional statement fails this is 0 and we set ouput to 0
	
	wire [31:0] SHRORr, ADDr, SUBr, MULr, ORr, ANDr, XORr, MOVr, MOVIMr, RSHr, LSHr, RROTr; //intermediary variables for module outputs
	wire carry, borrow, aV, sV;	//intermediary flag holders
	wire [3:0] CMPflags; //intermediary flag output for CMP module
	
	//init all modules, all results are calculated and case statment 
	//acts as MUX to connect the desired OP result to the ALU output
	
	//shift and rotate operations occur before checking conditions,
	//and occur on Source 2
	//if we are doing a shift or rotate operation
	ShiftROR #(32) shrorer (i_in2, i_shiftamt, SRcon, SHRORr);
	
	NAdder #(32) nadd (i_in1, SHRORr, 1'b0, ADDr, carry, aV);
	NSubtractor #(32) sub (i_in1, SHRORr, 1'b0, SUBr, borrow, sV);
	NMultiplier #(32) mult (i_in1, SHRORr, MULr);
	BitWiseOr #(32) or1 (i_in1, SHRORr, ORr);
	BitWiseAnd #(32) and1 (i_in1, SHRORr, ANDr);
	BitWiseXor #(32) xor1 (i_in1, SHRORr, XORr);
	Compare #(32) cmp (i_in1, i_in2, CMPflags);
	Mover move(SHRORr, i_imval, MOVr, MOVIMr);
	
	always@(*)
	begin
		//if we are checking for conditional execution we use a case 
		//for each condition and set a flag if the condition is true
		//if there is no condition to check flag is default 1
		if (Cond)
		begin
			flag = 0;
			case(Cond)
				4'b0001: if (CMPflags[2]) 								flag=1; //Z==1
				4'b0010: if ((CMPflags[2]==0)&&(CMPflags[3]==CMPflags[0]))  flag=1; //Z==0 & N==V
				4'b0011: if (CMPflags[3]!=CMPflags[0]) 					flag=1; //N!=V
				4'b0100: if (CMPflags[3]==CMPflags[0]) 					flag=1; //N==V
				4'b0101: if (CMPflags[2]||(CMPflags[3]==CMPflags[0])) 	flag=1; //Z==1||N!=V
				4'b0110: if (CMPflags[1]&&(CMPflags[2]==0)) 			flag=1; //C==1&&Z==0
				4'b0111: if (CMPflags[1]==0)							flag=1; //C==0
				4'b1000: if (CMPflags[1]==1) 							flag=1; //C==1
			endcase
		end
		else flag = 1;
		
		//if the flag is 1 or True then we go to check the OP code 
		//and perform the correct operations
		if (flag)
		begin
			case(OP)
				4'b0000: o_result = ADDr;		//ADD
				4'b0001: o_result = SUBr;		//SUB
				4'b0010: o_result = MULr;		//MUL
				4'b0011: o_result = ORr;		//ORR
				4'b0100: o_result = ANDr;		//AND
				4'b0101: o_result = XORr;		//EOR
				4'b0110: o_result = MOVIMr;		//MOV immediate value
				4'b0111: o_result = MOVr;		//MOV registers
				4'b1000: o_result = 32'bx;		//CMP
				4'b1001: o_result = 32'bx; 		//LDR
				4'b1010: o_result = 32'bx;		//STR
				4'b1111: o_result = o_result;	//NOP
				default: o_result = 32'bx;
			endcase
			

		end
		else o_result=32'bx;

		//N is if result is negative
		//Z is if result is 0
		//C is if result has a value past the MSB
		//If two numbers with the same sign (both positive or both negative) are added, then overflow occurs if and only if the result has the opposite sign.
		//If two numbers with the same sign (both positive or both negative) are subtracted
		
		
		if (OP==4'b1000) o_Conflags = CMPflags;
		else
		begin
			if (S)
			begin
				if (o_result[31]===1'bx) o_Conflags[3]=0;//if MSB is x then N=0
				else o_Conflags[3] = o_result[31];	//if the output MSB is 1 then N=1
				if (o_result==0) o_Conflags[2] = 1; //Z=1 if output is 0
				else o_Conflags[2] = 0;	//Z=0 if output isnt 0
				o_Conflags[1] = (carry);	//C removed borrow because ziad said so
				o_Conflags[0] = (aV | sV);	//V
			end
			//else o_Conflags = 4'b0000;
		end
		
		
		
		//~ if (instrc) o_programcounter = o_programcounter+1;
		//~ else o_programcounter = o_programcounter;
	end
	
	always @(posedge Clk)
	begin
		if (instrc) o_programcounter = o_programcounter+1;
		else o_programcounter = o_programcounter;
	end
endmodule
