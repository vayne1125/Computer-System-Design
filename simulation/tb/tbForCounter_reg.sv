`timescale 1ns/10ps
module tbForCounter_reg;

	logic reset;					//重置
	logic clk;						//時脈
	logic [3:0] q; 	  			    //輸出
	logic load_w;

	counter_reg counter_reg1(
		.reset(reset), //()內的變數為tb的變數，"."後面為counter_reg.sv的變數，將2者對應起來
		.clk(clk),
		.q(q),
		.load_w(load_w)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1;clk = 0;load_w = 1; //一開始先reset，將時脈歸0
		#15 reset = 0; 
		#1000 $stop;
	end
endmodule