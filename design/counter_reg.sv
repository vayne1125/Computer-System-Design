`timescale 1ns/10ps
module counter_reg(
	input clk,
	input reset,
	input load_w,
	output logic[3:0] q
);

	logic cp1,cp2;
	logic [3:0] a,b;
	logic [1:0] ps,ns;
	
	always_ff @(posedge clk)       //fsm
	begin 
		if(reset)
			ps <= #1 0;
		else 
			ps <= #1 ns;
	end
	
	always_ff @(posedge clk)      //counter1
	begin
		if(reset) a <= #1 0;
		else if(cp1) a <= #1 a + 1;
	end
	
	always_ff @(posedge clk)      //counter2
	begin
		if(reset) b <= #1 0;
		else if(cp2) b <= #1 b + 1;
	end
	
	parameter STATE_TOGTHER = 0;
	parameter STATE_CNT1 = 1;
	parameter STATE_STOP = 2;
	
	always_comb
	begin
		cp1 = 0; cp2 = 0;
		case(ps)
			STATE_TOGTHER:
			begin
				if(b == 4'd4) 
					begin
						cp1 = 1;
						ns = STATE_CNT1;
					end
				else 
					begin
						ns = STATE_TOGTHER;
						cp1 = 1;
						cp2 = 1;
					end
			end

			STATE_CNT1:
			begin
				if(a == 4'd9) ns = STATE_STOP;
				else 
					begin
						ns = STATE_CNT1;
						cp1 = 1;
					end
			end
			
			STATE_STOP:
			ns = STATE_STOP;
				
		endcase
	end
	
	always_comb
	begin
		if(load_w == 1)
			q = a+b;
		else 
			q = q;
	end
endmodule
	
	