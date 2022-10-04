`timescale 1ns/10ps
module testbench;

	logic reset;					//重置
	logic clk;						//時脈
	logic [1:0] R,Y,G; 	 		    //輸出

	RYG_light RYG_light1(
		.reset(reset), //()內的變數為tb的變數，"."後面為RYG_light.sv的變數，將2者對應起來
		.clk(clk),
		.R(R),
		.G(G),
		.Y(Y)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1;clk = 0; //一開始先reset，將時脈歸0
		#15 reset = 0; 
		#1000 $stop;
	end
endmodule