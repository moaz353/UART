//* uart_rx_deserializer builds the complete frame [start bit, 8-bit data, parity bit (optional), stop bit] 
//*                              11 bits with high par_en ; 
//*                              10 bits with low par_en ; 

module uart_rx_deserializer (clk , rst_n , deser_en , par_en ,  sampled_bit , bit_cnt , edge_cnt , data_valid , calc_par_bit , p_data ) ; 

input clk ; 
input rst_n ; 

input sampled_bit ;        //* from uart_rx_data_sampling

input deser_en  ;         //* from uart_rx_controller 
input data_valid ;        //* from uart_rx_controller  
input calc_par_bit  ;     //* from uart_rx_parity_check
input [2:0] edge_cnt ;     //* from edge_bit_counter 
input [3:0] bit_cnt ;     //* from edge_bit_counter 
input par_en  ; 

output [10:0] p_data ; 

reg [7:0] p_data_temp ; 

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin 
        p_data_temp <= 0 ;
    end 
    else begin 
        if (deser_en && edge_cnt == 4 && bit_cnt >= 2 && bit_cnt < 10 ) begin
            p_data_temp[bit_cnt-2] <= sampled_bit ; 
        end
    end
end

assign p_data = (data_valid)?( (par_en)? {1'b0, p_data_temp , calc_par_bit , 1'b1 } : {1'b0, p_data_temp , 1'b1 , 1'b1 } ) : 11'b0 ; 

endmodule 