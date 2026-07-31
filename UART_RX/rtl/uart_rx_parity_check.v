//* parity bit : 
//*             '0' even : we want to make number of 1's even:
//*                       so if actually num is odd we the addition bit will be 1
//*                       and if actually num is even we the addition bit will be 0
//* 
//*             '1' odd  : we want to make number of 1's odd:
//*                       so if actual num is odd we the addition bit will be 0
//*                       and if actual num is even we the addition bit will be 1

module uart_rx_parity_check ( clk , rst_n , par_typ , par_chk_en , sampled_bit , calc_par_bit_en , data_valid_par_chk , edge_cnt  ,  par_err , calc_par_bit) ;

input wire  clk        ; 
input wire  rst_n      ;

input wire par_typ     ;    //* 0 > even   // from uart_rx_controller 
input wire par_chk_en  ;                  //* from uart_rx_controller
input wire sampled_bit ;                  //* from uart_rx_data_sampling
input wire [2:0] edge_cnt     ; 

input wire data_valid_par_chk  ; //* this signal from uart_rx_controller controller to manage valid data to parity checker . send it after start_bit in frame. // from uart_rx_controller
input wire calc_par_bit_en   ;   //* this signal from uart_rx_controller controller to enable par bit calc . // from uart_rx_controller

output wire par_err   ;



output reg      calc_par_bit    ; 


always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin 
        calc_par_bit <= 0 ; 
    
    end 
    else if (~calc_par_bit_en) begin 
        if (~par_typ)
            calc_par_bit <= 0 ;    //* to start calc even parity bit with calc_par_bit = 0 ; 
        else  
            calc_par_bit <= 1 ;    //* to use same formula of even parity bit and start with calc_par_bit = 1 ; 
    end 
    else begin            
        if (data_valid_par_chk) begin
            
            if (par_typ) begin 
                if(edge_cnt == 4 ) 
                    calc_par_bit <= calc_par_bit ^ sampled_bit ;   //* odd  
            end
            
            else begin 
                if(edge_cnt == 4  )
                    calc_par_bit <= calc_par_bit ^ sampled_bit ;  //* even 
            end
        end
    end
end

assign par_err = (par_chk_en && edge_cnt == 7)? ((calc_par_bit != sampled_bit) ? 1 : 0 ) : 0 ;
endmodule