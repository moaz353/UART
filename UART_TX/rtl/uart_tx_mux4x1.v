module uart_tx_mux4x1(in0 , in1 , in2 , in3 , mux_out , mux_sel ) ; 

input [1:0] mux_sel ; 

input in0 ; 
input in1 ; 
input in2 ; 
input in3 ; 

output reg mux_out ; 

always @(*) begin
    case (mux_sel)
        2'b00 : mux_out = in0 ;  
        2'b01 : mux_out = in1 ;  
        2'b10 : mux_out = in2 ;  
        2'b11 : mux_out = in3 ;  
        default: mux_out = in0 ;  
    endcase
end

endmodule
