`timescale 1ns/10ps
module counter_abc(
	input clk,
	input reset,
	output logic [2:0] a,
	output logic [2:0] b,
	output logic [2:0] c
);

	logic cnt_a, cnt_b, cnt_c;
	logic [3:0] ps,ns;
	//logic [2:0] a,b,c;
	
	always_ff @(posedge clk)
	begin 
		if(reset) ps <= #1 0;
		else ps <= #1 ns;
	end
	
	always_ff @(posedge clk)
	begin
		if(reset) a <= #1 0;
		else if(cnt_a) a <= a + 1;
	end
	
	always_ff @(posedge clk)
	begin
		if(reset) b <= #1 0;
		else if(cnt_b) b <= b + 1;
	end
	
	
	always_ff @(posedge clk)
	begin
		if(reset) c <= #1 0;
		else if(cnt_c) c <= c + 1;
	end
	
	parameter STATE_A = 0;
	parameter STATE_B = 1;
	parameter STATE_C = 2;
	parameter STATE_STOP = 3;
	
	always_comb
	begin
		cnt_a = 0; cnt_b = 0; cnt_c = 0;
		case(ps)
			STATE_A:
			begin
				if(a == 3'd5) ns = STATE_B;
				else 
					begin
						ns = STATE_A;
						cnt_a = 1;
					end
			end

			STATE_B:
			begin
				if(b == 6) ns = STATE_C;
				else 
					begin
						ns = STATE_B;
						cnt_b = 1;
					end
			end
	
			STATE_C:
			begin
				if(c == 7) ns = STATE_STOP;
				else 
					begin
						cnt_c = 1;
						ns = STATE_C;
					end
			end
		endcase
	end
endmodule
			
		
		
	