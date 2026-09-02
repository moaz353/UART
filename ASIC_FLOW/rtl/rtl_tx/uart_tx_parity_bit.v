module uart_tx_parity_bit ( clk , rst_n , p_data , par_typ , par_bit ) ; 

input clk        ; 
input rst_n      ; 

input [7:0] p_data  ; 
input       par_typ ; 

output  reg   par_bit     ; 


always @(posedge clk ) begin 
    if (~rst_n) 
        par_bit <= 0 ; 
    else begin 
        if(par_typ)   begin                //* 1 >> odd parity bit          
                if(^p_data)
                        par_bit <= 0 ; 
                else 
                        par_bit <= 1 ;
        end
        else  begin                        //* 0 >> even parity bit 
                if(^p_data)
                        par_bit <= 1 ; 
                else 
                        par_bit <= 0 ;
        end
    end
end

endmodule 