module tbForSevenSegment;

	logic [3:0] A;
	logic [6:0] y;
 
	seven_segment seven_segment1(
		.A(A), //()內的變數為tb的變數，"."後面為seven_segment.sv的變數，將2者對應起來
		.y(y)
	);

	initial begin
		#10 A = 0; //延遲10ms，所以會從10後開始顯示結果
		#10 A = 1; //每10ms改變一次A，當A改變y也會改變
		#10 A = 2; 
		#10 A = 3;
		#10 A = 4;
		#10 A = 5; 
		#10 A = 6; 
		#10 A = 7;
		#10 A = 8;
		#10 A = 9;
		#10 A = 10;
		#10 A = 11;
		#10 A = 12;
		#10 A = 13;
		#10 A = 14;
		#10 A = 15;
		#1000 $stop;
	end
endmodule