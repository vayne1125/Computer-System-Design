`timescale 1ns/10ps
module hw_1107(
	input clk,
	input reset,
	output logic [7:0] w_q
);
	logic [10:0] pc_next, pc_q,mar_q;
	logic load_pc, load_mar, load_ir_q,load_w;
	logic [13:0] Rom_out,ir_q;
	logic reset_ir_q;
	logic [2:0] ps,ns;
	logic [2:0] op;
	logic [7:0] alu_q;
	logic MOVLW;
	logic ADDLW;
	logic SUBLW;
	logic ANDLW;
	logic IORLW;
	logic XORLW;
	//-------------pc------------
	assign pc_next = pc_q + 1;            //找到下一個指令
	
	always_ff @(posedge clk)              //有load信號，再讀取
	begin	
		if(reset)
			pc_q <= #1 0;
		else if(load_pc)
			pc_q <= #1 pc_next;
	end
	
	//------------mar-----------
	always_ff @(posedge clk)
	begin
		if(load_mar)
			mar_q <= #1 pc_q;
	end
	
	//------------ROM-----------
	Program_Rom rom1(Rom_out,mar_q);
	
	//------------IR------------
	always_ff @(posedge clk)
	begin
		if(reset_ir_q)
			ir_q <= #1 0;
		else if(load_ir_q)
			ir_q <= #1 Rom_out;
	end
	
	//--------load_w------------
	always_ff @(posedge clk)
	begin
		if(reset)
			w_q <= #1 0;
		else if(load_w)
			w_q <= #1 alu_q;
	end
	
	//--------controller--------
	//解碼指令，並給op值
	assign MOVLW = (ir_q[13:8] == 6'b110000);         
	assign ADDLW = (ir_q[13:8] == 6'b111110);
	assign SUBLW = (ir_q[13:8] == 6'b111100);
	assign ANDLW = (ir_q[13:8] == 6'b111001);
	assign IORLW = (ir_q[13:8] == 6'b111000);
	assign XORLW = (ir_q[13:8] == 6'b111010);
	
	always_comb                                    
	begin
		if(reset)
			op <= #1 0;
		else 
			begin			
				if(MOVLW) op = 5;
				else if(ADDLW) op = 0;
				else if(SUBLW) op = 1;
				else if(ANDLW) op = 2;
				else if(IORLW) op = 3;
				else if(XORLW) op = 4;
				else op = 6;
			end
	end
	
	//--------alu--------- 用op決定計算結果
	always_comb
	begin
		if(reset)
			alu_q <= #1 0;
		else 
			begin
				case(op)
					0: alu_q = ir_q[7:0] + w_q;
					1: alu_q = ir_q[7:0] - w_q;
					2: alu_q = ir_q[7:0] & w_q;
					3: alu_q = ir_q[7:0] | w_q;
					4: alu_q = ir_q[7:0] ^ w_q;
					5: alu_q = ir_q[7:0];
				endcase
			end
	end
	
	
	//--------fsm---------  有限狀態機
	parameter T0 = 0;
	parameter T1 = 1;
	parameter T2 = 2;
	parameter T3 = 3;
	parameter T4 = 4;
	parameter T5 = 5;
	parameter T6 = 6;
	
	always_ff @(posedge clk)
	begin
		if(reset) ps <= #1 0;
		else ps <= #1 ns;
	end
	
	always_comb
	begin                         //初始化
	load_mar = 0;
	load_pc = 0;
	reset_ir_q = 0;
	load_ir_q = 0;
	load_w = 0;
	ns = 0;
		case(ps)                   
		T0:                        //初始化ir_q
			begin
				reset_ir_q = 1;	
				ns = T1;
			end
			
		T1:
			begin
				load_mar = 1;        //load mar
				ns = T2;			
			end	
			
		T2:
			begin            
				load_pc = 1;	      //load pc
				ns = T3;			
			end	
	
		T3:
			begin                   //load ir_q
				load_ir_q = 1;	      
				ns = T4;			      
			end	

		T4:                        //load w
			begin
				load_w = 1;
				ns = T5;
			end
		
		T5:                        //空狀態
			begin
				ns = T6;
			end
		T6:
			begin
				ns = T1;
			end
	endcase
	end
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	