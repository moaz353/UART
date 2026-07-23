module uart_tx (clk , rst_n , p_data , data_valid , par_en ,
                    par_typ , tx_out , busy ) ; 


input       clk        ; 
input       rst_n      ; 

input [7:0] p_data     ; 
input       data_valid ; 
input       par_en     ; 
input       par_typ    ; 

output      tx_out     ; 
output      busy       ;


wire       ser_done ; 
wire [1:0] mux_sel ;
wire       ser_en ;
wire       par_bit ;
wire       ser_data ;


//* uart_tx_controller Module ; 
uart_tx_controller uart_tx_controller_mod (
    .clk       (clk),
    .rst_n     (rst_n),
    .data_valid(data_valid),
    .par_en    (par_en),
    .ser_done  (ser_done),               
    .mux_sel   (mux_sel),  //*output mux select signal
    .busy      (busy),
    .ser_en    (ser_en)    //*output serializer enable signal
);
//* uart_tx_parity_bit Module ;
uart_tx_parity_bit uart_tx_parity_bit_mod (
    .clk     (clk),
    .rst_n   (rst_n),
    .p_data  (p_data),
    .par_typ (par_typ),
    .par_bit (par_bit)    //* output parity bit
);

//* uart_tx_serializer Module ;
uart_tx_serializer uart_tx_serializer_mod (
    .clk      (clk),
    .rst_n    (rst_n),
    .p_data   (p_data),
    .ser_en   (ser_en),                    
    .ser_done (ser_done),                 
    .ser_data (ser_data)   //*output serial data
);


//* uart_tx_mux4x1 Module ;
uart_tx_mux4x1 uart_tx_mux4x1_mod (
    .in0     (1'b0),       //* Start bit = 0
    .in1     (1'b1),       //* Stop bit = 1
    .in2     (ser_data),   //* Serial data from serializer        
    .in3     (par_bit),    //* Parity bit from parity_bit module  
    .mux_out (tx_out),     //* Output to tx_out
    .mux_sel (mux_sel)    
);

endmodule