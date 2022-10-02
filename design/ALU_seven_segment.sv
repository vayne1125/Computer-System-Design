module ALU_seven_segment(
	input [3:0] A,			//輸入
	input [3:0] B,
	input op, 				//控制+-
	output logic [6:0] seven_seg //輸出
);

logic [3:0] S; //宣告變數S
//直接呼叫第2.3小題做的元件
ALU_add_sub alu_add_sub1(A,B,op,S);         //如果op=0，將A,B相加，反則相減 。將結果放入S
seven_segment seven_segment1(S,seven_seg);  //將S以七段顯示器的顯示方式存入seven_seg
	
endmodule