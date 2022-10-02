`timescale 1ns/10ps
module testbench;

	logic [2:0] q;
	logic [3:0] num;
	logic clk;
	logic reset;

	counter_8 counter_81(
		.q(q), //()內的變數為tb的變數，"."後面為ALU_add_sub.sv的變數，將2者對應起來
		.clk(clk),
		.reset(reset)
	);

	student_num sn1(
		.a(q),
		.num(num) //輸出
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1;clk = 0;
		#15 reset = 0;
		#1000 $stop;
	end
endmodule