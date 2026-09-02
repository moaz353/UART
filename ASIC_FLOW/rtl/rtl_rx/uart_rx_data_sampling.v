//* sample rx_in three times at counts (3, 4, 5) and apply majority voting

module uart_rx_data_sampling (clk , rst_n , rx_in , data_samp_en ,
                        edge_cnt , bit_cnt , sampled_bit); 

input clk   ; 
input rst_n ; 
input rx_in ; 

input data_samp_en ;  //* from uart_rx_controller 

input  [2:0] edge_cnt ;  //* from uart_rx_counters 
input  [3:0] bit_cnt  ;  //* from uart_rx_counters 

output reg sampled_bit ; 


reg [2:0] three_samps_data ; 

always @(posedge clk or negedge rst_n ) begin
    if(~rst_n) 
        three_samps_data <= 3'b0 ;    
    else begin 
        if(data_samp_en) begin
            if(edge_cnt == 3'b011) 
                three_samps_data[0] <= rx_in ; 
            if (edge_cnt == 3'b100 )  
                three_samps_data[1] <= rx_in ; 
            if (edge_cnt ==3'b101)  
                three_samps_data[2] <= rx_in ; 
        end
    end
end

always@(posedge clk or negedge rst_n) begin
    if (~rst_n) 
        sampled_bit <= 0 ; 
    else begin 
        if (bit_cnt && edge_cnt == 0 ) begin 
            case(three_samps_data) 
                3'b000  : sampled_bit <= 0 ; 
                3'b001  : sampled_bit <= 0 ; 
                3'b010  : sampled_bit <= 0 ; 
                3'b011  : sampled_bit <= 1 ; 
                3'b100  : sampled_bit <= 0 ; 
                3'b101  : sampled_bit <= 1 ; 
                3'b110  : sampled_bit <= 1 ; 
                3'b111  : sampled_bit <= 1 ; 
                default : sampled_bit <= 1 ;
            endcase
        end
    end
end 
endmodule 