module Program_Rom(Rom_data_out, Rom_addr_in);

//---------
    output [13:0] Rom_data_out;
    input [10:0] Rom_addr_in; 
//---------
    
    reg   [13:0] data;
    wire  [13:0] Rom_data_out;
    
    always @(Rom_addr_in)
        begin
            case (Rom_addr_in)             
                11'h0 : data = 14'h3701;  //MOVLX 1
                11'h1 : data = 14'h010C;  //ADDLXW 12
				11'h2 : data = 14'h3002;  //MOVLW 2
                11'h3 : data = 14'h3E02;  //ADDLW 2
				11'h4 : data = 14'h3706;  //MOVLX 6
				11'h5 : data = 14'h3E07;  //ADDLW 7
				11'h6 : data = 14'h3907;  //ANDLW 7
				11'h7 : data = 14'h020E;  //ANDLXW 14
                default: data = 14'h0;   
            endcase
        end

     assign Rom_data_out = data;

endmodule
