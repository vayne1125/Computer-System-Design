module tbForALU_7seg;

	logic [3:0] A;
	logic [3:0] B;
	logic [3:0] seven_seg;
	logic op;

	ALU_seven_segment ALU_seven_segment1(
		.A(A), //()內的變數為tb的變數，"."後面為ALU_add_sub.sv的變數，將2者對應起來
		.B(B),
		.seven_seg(seven_seg),
		.op(op)
	);

	initial begin
		#10 A = 4'h5; B = 4'hB; op = 0; //延遲10ms，所以會從10後開始顯示結果
		#10 A = 4'hC; B = 4'h2; op = 0; //每10ms改變一次A，B，op，當他們改變seven_seg也會改變
		#10 A = 4'h9; B = 4'h4; op = 1; 
		#10 A = 4'h3; B = 4'hB; op = 1;
		#10 A = 4'hD; B = 4'h7; op = 1;
		#1000 $stop;
	end
endmodule