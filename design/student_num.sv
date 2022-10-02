`timescale 1ns/10ps
module student_num(
	input [2:0] a,
	output logic [3:0] num //輸出
);

	always_comb 
		begin
			case (a)
				3'd0 : num = 0;
				3'd1 : num = 0;
				3'd2 : num = 9;
				3'd3 : num = 5;
				3'd4 : num = 7;
				3'd5 : num = 1;
				3'd6 : num = 1;
				3'd7 : num = 6;
			endcase
		end
endmodule