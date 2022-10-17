`timescale 1ns/10ps
module testbench;

	logic reset;					//重置
	logic clk;						//時脈
	logic [7:0] port_A; 	 		//輸出
	logic [7:0] port_B;

	hw_1017_1 hw_1017_11(
		.reset(reset), //()內的變數為tb的變數，"."後面為hw_1017_1.sv的變數，將2者對應起來
		.clk(clk),
		.port_A(port_A),
		.port_B(port_B)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1;clk = 0; //一開始先reset，將時脈歸0
		#15 reset = 0; 
		#1000 $stop;
	end
endmodule