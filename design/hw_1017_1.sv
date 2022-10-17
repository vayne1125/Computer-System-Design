`timescale 1ns/10ps
module hw_1017_1(
	input clk,                     //時脈
	input reset,				       //reset
	output logic [7:0] port_A,     //output
	output logic [7:0] port_B
);

	logic load_w;            //load_w控制線
	logic load_A;            //load_A控制線
	logic load_B;            //load_B控制線
	logic [4:0] ps,ns;		 //現在狀態 下一個狀態
	logic [7:0] B;           //計數器 中間的值
	logic [7:0] S;           //S = W+B
	logic [7:0] W;           
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
	
	always_ff @(posedge clk)       //A載入器
	begin 
		if(reset)
			port_A	<= #1 0;
		else if(load_A) 
			port_A	<= #1 W;
	end
	
	always_ff @(posedge clk)       //B載入器
	begin 
		if(reset)
			port_B	<= #1 0;
		else if(load_B) 
			port_B	<= #1 W;
	end
	
	always_ff @(posedge clk)       //counter
	begin 
		if(reset)
			B	<= #1 0;
		else if(cnt) 
			B	<= #1 B + 1;
	end
	
	assign S = W + B;
		
	always_comb
	begin
	ns = 0;
	load_w = 1;
	load_A = 0;
	load_B = 0;
	cnt = 1;
	case(ps)         
			0:         
			begin
				ns = 1;
			end
			
			1:          
			begin
				ns = 2;
			end
			
			2:          
			begin
				ns = 3;
			end
			
			3:          
			begin
				ns = 4;
			end
			
			4:          
			begin
				ns = 5;
			end
			
			5:          
			begin
				ns = 6;
			endD
			
			6:          
			begin
				ns = 7;
			end
			
			7:          
			begin
				ns = 8;
			end
			
			8:          
			begin
				ns = 9;
			end
			
			9:          
			begin
				ns = 10;
			end
			
			10:          
			begin
				ns = 11;
			end
			
			11:          
			begin                 //在ns = 10時，w會得到(1+~+10)的結果
				load_A = 1;        //所以load_A要在n=11時load，才能拿到w的值
				ns = 12;
			end
			
			12:          
			begin
				ns = 13;
			end
			
			13:          
			begin
				ns = 14;
			end
			
			14:          
			begin
				ns = 15;
			end

			15:          
			begin
				ns = 16;
			end	
	
			16:          
			begin
				ns = 17;
			end
		
			17:          
			begin
				ns = 18;
			end
		
			18:          
			begin
				ns = 19;
			end	
			
			19:          
			begin
				ns = 20;
			end	
	
			20:          
			begin
				ns = 21;
			end	
			
			21:          
			begin                 
				load_B =1;			//在ns = 20時，w會得到(1+~+20)的結果
				cnt = 0;				//所以load_B要在n=21時load，才能拿到w的值
				ns = 22;
			end
			
			22:                  //停止狀態
			begin
				load_w = 0;
				cnt = 0;
				ns = 22;
			end
		endcase
	end


endmodule
	
	