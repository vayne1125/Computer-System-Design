`timescale 1ns/10ps
module testbench;

	logic reset;					//重置
	logic clk;						//時脈
	logic [7:0] W; 	 				//輸出

	hw_1017_2 hw_1017_21(
		.reset(reset), //()內的變數為tb的變數，"."後面為hw_1017_2.sv的變數，將2者對應起來
		.clk(clk),
		.W(W)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1;clk = 0; //一開始先reset，將時脈歸0
		#15 reset = 0; 
		#1000 $stop;
	end
endmodule