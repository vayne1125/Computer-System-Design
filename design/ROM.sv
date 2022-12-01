`timescale 1ns/10ps
module ROM(
	output [13:0] Rom_data_out, 
	input [10:0] Rom_addr_in
);
//---------
    
    logic [13:0] data;
    always_comb
        begin
            case (Rom_addr_in)
				11'h0:	data = 14'h01A5;		
				11'h1:	data = 14'h0103;		
				11'h2:	data = 14'h3007;		
				11'h3:	data = 14'h07A5;		
				11'h4:	data = 14'h0725;		
				11'h5:	data = 14'h2805;		
				11'h6:	data = 14'h3400;		
				11'h7:	data = 14'h3400;		
				default:data = 14'hX;
            endcase
        end
     assign Rom_data_out = data;

endmodule