`timescale 1ns/10ps
module clock(
	input reset,					//重置
	input clk,						//時脈
	output logic [27:0] q,	   //輸出
	output logic [15:0] s      //輸出16進位，方便debug
);

logic carry_out1,carry_out2;

//計數器，負責分鐘
counter_BCD_min counter_BCD_min1(reset, clk, q[13:0], s[7:0], carry_out1);

//計數器，負責小時
counter_BCD_hour counter_BCD_hour1(reset, clk, carry_out1, q[27:14], s[15:8]);
	
endmodule
