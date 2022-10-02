module tbForMux8to1;

	logic [2:0] a0, a1, a2, a3, a4, a5, a6, a7; 
	logic [2:0] y;
	logic [2:0] sel;
 
	mux_8to1 mux(
		.a0(a0), //()內的變數為tb的變數，"."後面為mux_8to1.sv的變數，將2者對應起來
		.a1(a1),
		.a2(a2),
		.a3(a3),
		.a4(a4),
		.a5(a5),
		.a6(a6),
		.a7(a7), 
		.sel(sel),
		.y(y)
	);

	initial begin
		a0 = 0; a1 = 1; a2 = 2; a3 = 3; a4 = 4; a5 = 5; a6 = 6; a7 = 7; //指定input的值
		#10 sel = 0; //延遲10ms，所以會從10後開始顯示結果
		#10 sel = 1; //每10ms改變一次sel，當sel改變y也會改變
		#10 sel = 2; 
		#10 sel = 3;
		#10 sel = 4;
		#10 sel = 5; 
		#10 sel = 6; 
		#10 sel = 7; 
		#1000 $stop;
	end
endmodule