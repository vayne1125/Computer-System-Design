`timescale 1ns/10ps
module counter_4bit_0_9_0_3(
	input reset,					//重置
	input clk,						//時脈
	input carry_in, 				//進位輸入
	output logic [3:0] value, 	//輸出
	output logic carry_out,		//進位輸出
	input mode 						//模式選擇 0:0~9，1:0~3  
);

	always_ff @ (posedge clk)
		begin
			if(reset)              //同步，如果reset 就把值歸0
				value <= #1 0;
			else if(value == 4'd9 && carry_in == 1 && mode == 0) //mode = 0 ，數到9把值歸0
				value <= #1 0;
			else if(value == 4'd3 && carry_in == 1 && mode == 1) //mode = 1 ，數到3把值歸0
				value <= #1 0;
			else if(carry_in == 1)
				value <= #1 value + 1; //值加1
		end
	
	//當value = 9 && carry_in = 1 && mode = 0 時 或 當value = 3 && carry_in = 1 && mode = 1 時 ，有進位
	assign carry_out = ((value == 4'd9 && carry_in == 1 && mode == 0) || (value == 4'd3 && carry_in == 1 && mode == 1))?1:0;
	
endmodule