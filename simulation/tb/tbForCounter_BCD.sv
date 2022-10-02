`timescale 1ns/10ps
module tbForCounter_BCD;

	logic reset;					//重置
	logic clk;						//時脈
	logic [13:0] q; 	  			//輸出
	logic [7:0] s; 					//16進位數字 方便debug

	counter_BCD counter_BCD1(
		.reset(reset), //()內的變數為tb的變數，"."後面為counter_BCD1.sv的變數，將2者對應起來
		.clk(clk),
		.q(q),
		.s(s)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1;clk = 0; //一開始先reset，將時脈歸0
		#15 reset = 0; 
		#2500 $stop;
	end
endmodule