
// to check the sampled bit is one or not ; 
// correct stop bit is 1 ;
module uart_rx_stop_check (clk , rst_n ,sampled_bit , stp_chk_en , stp_err  ) ; 

input clk ; 
input rst_n ; 

input sampled_bit ;  // from uart_rx_data_sampling
input stp_chk_en ;   // from uart_rx_controller 

output reg stp_err ; // if 0 the sampled bit is actual stop bit of the frame ; 


always @ (posedge clk or negedge rst_n) begin 
    if(~rst_n) 
        stp_err <= 0 ; 
    else begin 
        if(stp_chk_en) begin
            if(sampled_bit != 1 ) 
                stp_err <= 1 ; 
        end 
    end
end 

endmodule 
