module mux_8to1(
	//變數宣告
	input [2:0] a0, 
	input [2:0] a1, 
	input [2:0] a2,
	input [2:0] a3,
	input [2:0] a4,
	input [2:0] a5,
	input [2:0] a6,
	input [2:0] a7,
	input [2:0] sel,     // sel為選擇線，選擇y的值(a0,a1....)
	output logic[2:0] y  // 要加logic
);
always_comb
begin
	case(sel)  
		3'b000: y = a0; //當sel = 0時，y = a0，以此類推
		3'b001: y = a1; 
		3'b010: y = a2; 
		3'b011: y = a3; 
		3'b100: y = a4; 
		3'b101: y = a5; 
		3'b110: y = a6; 
		3'b111: y = a7; 
		default: y = 3'bx; //如果sel都不符合，y = 3'bx
	endcase
end
endmodule

