module Test_memcontrol;
	reg [31:0] s2, s1, i_databus;
	reg [3:0] OP;
	reg [31:0] i_ALU;
	
	wire [31:0] regdat, o_databus;
	wire[3:0] ramaddr;
	wire [1:0] RW;
	
	initial 
	begin
			OP=4'b1001; s2=4; s1=32'hAAAAAAAA; 
		#10 OP=4'b1010; i_databus=32'hBBBBBBBB;
		#10 s2=0;
		#10 OP=4'b0000;
	end

	initial
	begin
	$monitor($time, " OP=%b, RW=%b, Source2=%h, Source1=%h, o_ramaddr=%d, o_bus=%h, i_bus=%h, regdat=%h", OP, RW, s2, s1, ramaddr, o_databus, i_databus, regdat);
	end
	
	MemControl mem(OP, s1, s2, i_databus, i_ALU, o_databus, RW, regdat, ramaddr);
				//(OP, i_in1, i_in2, i_databus, i_ALU, o_databus, o_RW, o_regdat, o_ramaddr);
endmodule
