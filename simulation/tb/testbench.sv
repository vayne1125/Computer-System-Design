`timescale 1ns/10ps
module testbench;

	logic reset;					//重置
	logic clk;						//時脈
	logic [7:0] w_q; 	 				//輸出

	hw_1219 hw_1219_1(
		.reset(reset), //()內的變數為tb的變數，"."後面為hw_1219.sv的變數，將2者對應起來
		.clk(clk),
		.w_q(w_q)
	);

	always #1 clk = ~clk;

	initial begin
		reset = 1;clk = 0; //一開始先reset，將時脈歸0
		#15 reset = 0; 
		#140000 $stop;
	end
endmodule