`timescale 1ns/10ps
module counter_BCD(
	input reset,					//重置
	input clk,						//時脈
	output logic [13:0] q,	   //輸出
	output logic [7:0] s       //輸出16進位，方便debug <ex>1001,0001 -> 91
);

logic carry_out1,carry_out2;

//計數器，負責個位數，每次都要+1所以carry_in的位置放1，得到的值存在s[3:0]裡，進位放在carry_out1
counter_4bit_0_9 counter_4bit_0_9_1(reset, clk,          1, s[3:0], carry_out1);

//計數器，負責十位數，只有個位數有進位時才要+1,所以carry_in的位置放carry_out1，得到的值存在s[7:4]裡，進位放在carry_out2
counter_4bit_0_9 counter_4bit_0_9_2(reset, clk, carry_out1, s[7:4], carry_out2);

//個位數的七段顯示器，將s[3:0]轉成七段顯示
seven_segment seven_segment1(s[3:0],q[6:0]); 

//個位數的七段顯示器，將s[7:4]轉成七段顯示
seven_segment seven_segment2(s[7:4],q[13:7]);
	
endmodule
