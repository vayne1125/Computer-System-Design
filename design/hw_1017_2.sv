`timescale 1ns/10ps
module hw_1017_2(
	input clk,                     //時脈
	input reset,				       //reset
	output logic [3:0] W     //output
);

	logic load_w;            //load_w控制線
	logic [3:0] ps,ns;		 //現在狀態 下一個狀態
	logic [3:0] A;           // A = W
	logic [3:0] B;           //計數器，中間的值
	logic [3:0] S;           // S = A+B  
	logic [2:0] op;          //控制ALU的模式
	logic cnt;
	
	always_ff @(posedge clk)       //fsm
	begin 
		if(reset)
			ps <= #1 0;
		else 
			ps <= #1 ns;
	end
	
	always_ff @(posedge clk)       //W載入器
	begin 
		if(reset)
			W	<= #1 0;
		else if(load_w) 
			W	<= #1 S;
	end
	
	always_ff @(posedge clk)       //counter
	begin 
		if(reset)
			B	<= #1 0;
		else if(cnt) 
			B	<= #1 B + 1;
	end
	
	assign A = W;                 //將W拉到ALU當運算元，取叫A
		
	always_comb                   //ALU
	begin
		case(op)
			0:
				S = A + B;
			1:
				S = A - B;
			2:
				S = A * B;
			3:
				S = A / B;
			4:
				S = A & B;
			5:
				S = A | B;
			6:
				S = A ^ B;
		endcase
	end
	
	always_comb                  //狀態切換
	begin
	op = 0;                      //預設+
	ns = 0;                      //次態
	load_w = 1;                  //always load
	cnt = 1;                     //預設要加計數器
	case(ps)         
			0:         
			begin
				op = 0;
				ns = 1;
			end
			
			1:          
			begin
				op = 0;
				ns = 2;
			end
			
			2:          
			begin
				op = 5;
				ns = 3;
			end
			
			3:          
			begin
				op = 2;
				ns = 4;
			end
			
			4:          
			begin
				op = 1;
				ns = 5;
			end
			
			5:          
			begin
				op = 3;
				ns = 6;
			end
			
			6:          
			begin
				op = 0;
				ns = 7;
			end
			
			7:          
			begin
				op = 0;
				ns = 8;
			end
			
			8:          
			begin
				op = 6;
				ns = 9;
			end
			
			9:          
			begin
				op = 0;
				ns = 10;
			end
			
			10:          
			begin
				op = 4;
				ns = 11;
			end
			
			11:            //stop state
			begin     
			   cnt = 0;
				ns = 11;
				load_w = 0;
				op = 7;
			end
		endcase
	end
endmodule
	
	