module uart_rx_counters (clk , rst_n , enable , data_valid_cnt_en , cnt_zero , bit_cnt , edge_cnt , data_valid_cnt ); 

input clk ; 
input rst_n ; 

input enable ;            //? from uart_rx_controller 
input data_valid_cnt_en ; //? from uart_rx_controller 

input cnt_zero ;    //? from uart_rx_controller to zero the bit counter after finishing_ 
                    //? the process to prevent counter incr above 11 or 12 ; 

//* counters 
output reg  [3:0] bit_cnt ;         //* 11 or 11 bits 
output reg  [2:0] edge_cnt ;        //* 8 edges (0:7)
output reg  [2:0] data_valid_cnt ;  //* 8 edges (0:7) -> use to provide the output data on 8 RX clk cycles .   

always @(posedge clk or negedge rst_n) begin
    
    if(~rst_n) begin 
        edge_cnt <= 3'b0 ;
        bit_cnt  <= 4'b0 ;
    end
    else begin
        if (cnt_zero) begin
            edge_cnt <= 3'b0 ; 
            bit_cnt  <= 4'b0 ; 
        end
        if(enable) begin 
            edge_cnt <= edge_cnt + 1 ; 
                if(edge_cnt == 7) begin     //? edge counter == 7 
                    bit_cnt <= bit_cnt + 1 ; 
                end 
        end
    end        
end

always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) 
        data_valid_cnt <= 3'b0 ; 
    else begin 
        if (data_valid_cnt_en) 
            data_valid_cnt <= data_valid_cnt + 1 ; 
    end 
end
endmodule 
