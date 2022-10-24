`timescale 1ns/10ps
module testbench;

	logic reset;					//重置
	logic clk;						//時脈
	logic [14:0] IR; 	 				//輸出

	CPU CPU1(
		.reset(reset), //()內的變數為tb的變數，"."後面為CPU.sv的變數，將2者對應起來
		.clk(clk),
		.IR(IR)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1;clk = 0; //一開始先reset，將時脈歸0
		#15 reset = 0; 
		#1000 $stop;
	end
endmodule