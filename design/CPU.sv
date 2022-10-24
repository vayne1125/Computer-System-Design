`timescale 1ns/10ps
module CPU(
	input clk,
	input reset,
	output logic [13:0] IR
);
	logic [10:0] pc_next, pc_q,mar_q;
	logic load_pc, load_mar, load_IR;
	logic [13:0] Rom_out;
	logic reset_IR;
	logic [2:0] ps,ns;
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
	ROM rom1(Rom_out,mar_q);
	
	//------------IR------------
	always_ff @(posedge clk)
	begin
		if(reset_IR)
			IR <= #1 0;
		else if(load_IR)
			IR <= #1 Rom_out;
	end
	
	//--------controller--------
	
	parameter T0 = 0;
	parameter T1 = 1;
	parameter T2 = 2;
	parameter T3 = 3;
		
	always_ff @(posedge clk)
	begin
		if(reset) ps <= #1 0;
		else ps <= #1 ns;
	end
	
	always_comb
	begin
	load_mar = 0;
	load_pc = 0;
	reset_IR = 0;
	load_IR = 0;
	ns = 0;
		case(ps)                   
		T0:                        //初始化IR
			begin
				reset_IR = 1;	
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
			begin                   //load IR
				load_IR = 1;	      
				ns = T1;			      //一直重複T1,T2,T3
			end	
	endcase
	end
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	