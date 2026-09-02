
// to check the sampled bit is zero or not ; 
// correct start bit is 0 ; 
module uart_rx_start_check (clk , rst_n , sampled_bit , str_chk_en , str_glitch) ; 

input clk ; 
input rst_n ; 

input sampled_bit ;  // from uart_rx_data_sampling
input str_chk_en ;   // from uart_rx_controller

output reg str_glitch ; // if 0 the sampled bit is actual start bit of new frame ; 


always @ (posedge clk or negedge rst_n) begin 
    if(~rst_n) 
        str_glitch <= 0 ; 
    else begin 
        if(sampled_bit && str_chk_en) 
            str_glitch <= 1 ; 
        else 
            str_glitch <= 0 ; 
    end 
end 

endmodule 
