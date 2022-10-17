`timescale 1ns/10ps
module tbForCounter_abc;

	logic reset;					//重置
	logic clk;						//時脈
	logic [2:0] a,b,c; 	  			//輸出

	counter_abc counter_abc1(
		.reset(reset), //()內的變數為tb的變數，"."後面為clock.sv的變數，將2者對應起來
		.clk(clk),
		.a(a),
		.b(b),
		.c(c)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1;clk = 0; //一開始先reset，將時脈歸0
		#15 reset = 0; 
		#1000 $stop;
	end
endmodule