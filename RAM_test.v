module Test_RAM;
	reg [31:0] i_databus;
	reg [7:0] ProgC;
	reg [3:0] ramaddr;
	reg [1:0] RW;
	reg [31:0] temp;
	reg clock;
	wire [31:0] o_databus, o_instrfetch;
	
	initial  
	begin
	
			$readmemb("D:/verilog_projects/32'b cpu/1testinstractual.txt", ram.memory); 	RW=2'b00; ramaddr=32'd0; i_databus=0; ProgC=0; clock=1;
		#5  ramaddr=32'd1; ProgC=1; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd2; ProgC=2; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd3; ProgC=3; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd4; ProgC=4; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd5; ProgC=5; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd6; ProgC=6; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd7; ProgC=7; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd8; ProgC=8; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd9; ProgC=9; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd10; ProgC=10; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd11; ProgC=11; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd12; ProgC=12; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd13; ProgC=13; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd14; ProgC=14; temp=o_instrfetch[15:0];
		#5  ramaddr=32'd15; ProgC=15; temp=o_instrfetch[15:0];
		
			//~ RW=2'b10; ramaddr=32'd0; i_databus=32'hAAAA;
		//~ #5  ramaddr=32'd1; i_databus=32'hAAAB;
		//~ #5  ramaddr=32'd2; i_databus=32'hAAAC;
		//~ #5  ramaddr=32'd3; i_databus=32'hAAAD;
		//~ #5  ramaddr=32'd4; i_databus=32'hAAAE;
		//~ #5  ramaddr=32'd5; i_databus=32'hAAAF;
		//~ #5  ramaddr=32'd6; i_databus=32'hAABA;
		//~ #5  RW=2'b0; ramaddr=32'd0; 
		//~ #5  RW=2'b01; ramaddr=32'd2;
		//~ #5  ramaddr=32'd4;
		//~ #5  ramaddr=32'd6;
		
		#5	$writememb("D:/verilog_projects/32'b cpu/Ramtest.txt", ram.memory);
	end
	
	always #5 clock=~clock;
	
	initial
	begin
	$monitor($time, " RW=%b, addr=%d, in=%b, PC=%d, instr=%b, temp=%b, out=%b", RW,ramaddr,i_databus,ProgC, o_instrfetch, temp, o_databus);
	end
	
	RAM ram(clock, ramaddr, RW, i_databus, ProgC, o_databus, o_instrfetch);
endmodule
