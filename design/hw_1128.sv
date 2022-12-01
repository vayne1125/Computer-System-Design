`timescale 1ns/10ps
module hw_1128(
	input clk,
	input reset,
	output logic [7:0] w_q
);
	logic [10:0] pc_next, pc_q, mar_q;
	logic load_pc, load_mar, load_ir_q, load_w; //load線
	logic [13:0] Rom_out,ir_q;                  
	logic reset_ir_q;
	logic ram_en;
	logic [2:0] ps,ns;
	logic [3:0] op;
	logic [7:0] alu_q, mux_out, ram_out, databus, RAM_mux, bcf_mux, bsf_mux;
	logic [1:0] sel_RAM_mux;
	logic sel_alu,sel_pc,sel_bus;              //選擇線
	logic [2:0] sel_bit;

	//---------sel_pc-----------
	always_comb                          //下一個指令
	begin
		if(sel_pc) pc_next = ir_q[10:0];
		else pc_next = pc_q + 1;
	end
	
	always_ff @(posedge clk)             //有load信號，再讀取
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
	Program_Rom rom(Rom_out,mar_q);
	
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
	//-----------ram------------
	single_port_ram_128x8 ram(databus,ir_q[6:0],ram_en,clk,ram_out);
	
	//---------sel_alu----------
	always_comb
	begin
		if(sel_alu == 0) mux_out = ir_q[7:0];
		else mux_out = RAM_mux[7:0];
	end
	
	//---------sel_bus----------
	always_comb
	begin
		if(sel_bus == 0) databus = alu_q;
		else databus = w_q;
	end
	
	//---------ram_mux----------
	always_comb
	begin
		case(sel_RAM_mux)
		0: RAM_mux = ram_out;
		1: RAM_mux = bcf_mux; 
		2: RAM_mux = bsf_mux;
		endcase
	end
	
	//---------BCF_mux----------
	always_comb
	begin
		case(sel_bit)
			3'b000: bcf_mux = ram_out & 8'b1111_1110;
			3'b001: bcf_mux = ram_out & 8'b1111_1101;
			3'b010: bcf_mux = ram_out & 8'b1111_1011;
			3'b011: bcf_mux = ram_out & 8'b1111_0111;
			3'b100: bcf_mux = ram_out & 8'b1110_1111;
			3'b101: bcf_mux = ram_out & 8'b1101_1111;
			3'b110: bcf_mux = ram_out & 8'b1011_1111;
			3'b111: bcf_mux = ram_out & 8'b0111_1111;
		endcase
	end
	
	//---------BSF_mux----------
	always_comb
	begin
		case(sel_bit)
			3'b000: bsf_mux = ram_out | 8'b0000_0001;
			3'b001: bsf_mux = ram_out | 8'b0000_0010;
			3'b010: bsf_mux = ram_out | 8'b0000_0100;
			3'b011: bsf_mux = ram_out | 8'b0000_1000;
			3'b100: bsf_mux = ram_out | 8'b0001_0000;
			3'b101: bsf_mux = ram_out | 8'b0010_0000;
			3'b110: bsf_mux = ram_out | 8'b0100_0000;
			3'b111: bsf_mux = ram_out | 8'b1000_0000;
		endcase
	end
	
	//--------controller--------
	//解碼指令
	assign MOVLW = (ir_q[13:8] == 6'b110000);         
	assign ADDLW = (ir_q[13:8] == 6'b111110);
	assign SUBLW = (ir_q[13:8] == 6'b111100);
	assign ANDLW = (ir_q[13:8] == 6'b111001);
	assign IORLW = (ir_q[13:8] == 6'b111000);
	assign XORLW = (ir_q[13:8] == 6'b111010);
	
	assign d = ir_q[7];
	
	assign ADDWF = (ir_q[13:8] == 6'b000111);
	assign ANDWF = (ir_q[13:8] == 6'b000101);
	assign CLRF  = (ir_q[13:8] == 6'b000001);
	assign CLRW  = (ir_q[13:8] == 6'b000001);
	assign COMF  = (ir_q[13:8] == 6'b001001);
	assign DECF  = (ir_q[13:8] == 6'b000011);	
	assign GOTO  = (ir_q[13:11] == 3'b101);
	
	assign INCF  = (ir_q[13:8] == 6'b001010);
	assign IORWF = (ir_q[13:8] == 6'b000100);
	assign MOVF  = (ir_q[13:8] == 6'b001000);
	assign MOVWF = (ir_q[13:8] == 6'b000000);
	assign SUBWF = (ir_q[13:8] == 6'b000010);
	assign XORWF = (ir_q[13:8] == 6'b000110);
	
	assign BCF = (ir_q[13:10] == 4'b0100);
	assign BSF = (ir_q[13:10] == 4'b0101);
	assign BTFSC = (ir_q[13:10] == 4'b0110);
	assign BTFSS = (ir_q[13:10] == 4'b0111);
	assign DECFSZ = (ir_q[13:8] == 6'b001011);
	assign INCFSZ = (ir_q[13:8] == 6'b001111);
	
	assign sel_bit = ir_q[9:7];
	assign btfsc_skip_bit = (ram_out[ir_q[9:7]] == 0);
	assign btfss_skip_bit = (ram_out[ir_q[9:7]] == 1);
	assign btfsc_btfss_skip_bit = (BTFSC & btfsc_skip_bit) | (BTFSS & btfss_skip_bit);
	assign aluout_zero = (alu_q == 0);
	//--------alu--------- 用op決定計算結果
	always_comb
	begin
		if(reset)
			alu_q <= #1 0;
		else 
			begin
				case(op)
					0: alu_q = mux_out + w_q;
					1: alu_q = mux_out - w_q;
					2: alu_q = mux_out & w_q;
					3: alu_q = mux_out | w_q;
					4: alu_q = mux_out ^ w_q;
					5: alu_q = mux_out;
					6: alu_q = mux_out + 1;
					7: alu_q = mux_out - 1;
					8: alu_q = 0;
					9: alu_q = ~mux_out ;
					default: alu_q = mux_out + w_q;
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
	sel_pc = 0;
	sel_alu = 0;
	sel_bus = 0;
	ram_en = 0;
	sel_RAM_mux = 0;
	ns = 0;
		case(ps)                   
		T0:                        //初始化r_q
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
				if(MOVLW) op = 5;
				else if(ADDLW) op = 0;
				else if(SUBLW) op = 1;
				else if(ANDLW) op = 2;
				else if(IORLW) op = 3;
				else if(XORLW) op = 4;
				
				else if(ADDWF) op = 0;
				else if(ANDWF) op = 2;
				else if(CLRF)  op = 8;
				else if(CLRW)  op = 8;
				else if(COMF)  op = 9;
				else if(DECF)  op = 7;
				
				else if(INCF)  op = 6;
				else if(IORWF) op = 3;
				else if(MOVF)  op = 5;
				else if(SUBWF) op = 1;
				else if(XORWF) op = 4;
				
				else if(BCF || BSF) op = 5;
				else if(DECFSZ) op = 7;
				else if(INCFSZ) op = 6;
 				else op = 10;
	
				if(GOTO)
					begin
						sel_pc = 1;
						load_pc = 1;
					end
				else if(ADDWF || ANDWF || INCF || IORWF || MOVF || SUBWF || XORWF)
					begin
						sel_alu = 1;
						if(d==0) load_w = 1;
						else ram_en = 1;
					end
				else if(CLRF) ram_en = 1;
				else if(CLRW) load_w = 1;
				else if(COMF || DECF) 
					begin 
						sel_alu = 1;
						ram_en = 1;
					end
				else if(MOVWF)
					begin 
						sel_bus = 1;
						ram_en = 1;
					end
				else if(BCF || BSF)
					begin 
						sel_alu = 1;
						if(BCF) sel_RAM_mux = 1;  //BCF = 1,BSF = 2
						else sel_RAM_mux = 2;
						ram_en = 1;
					end
				else if(BTFSC || BTFSS)
					begin
						if(btfsc_btfss_skip_bit) load_pc = 1;
					end	
				else if(DECFSZ || INCFSZ)
					begin
						sel_alu = 1;
						if(d == 0) load_w = 1;
						else ram_en = 1;
						
						if(aluout_zero) load_pc = 1;
					end
				else 
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