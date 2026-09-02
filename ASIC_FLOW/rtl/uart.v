module uart ( clk , rst_n , p_data , data_valid , par_en , par_typ ,
                tx_out , busy , rx_in , rx_p_data , rx_data_valid );

input wire clk ;
input wire rst_n ;

input wire [7:0] p_data ;
input wire       data_valid ;
input wire       par_en ;
input wire       par_typ ;

output wire      tx_out ;
output wire      busy ;

input wire       rx_in ;
output wire [10:0] rx_p_data ;
output wire        rx_data_valid ;

//* baud-rate divider signals
reg  [2:0] baud_cnt ;
wire       tx_clk  ;

//*===========================================================
//* baud-rate divider : clk / 8
//*   - uart_tx is clocked by tx_clk (1 baud period = 8 clk)
//*   - uart_rx is clocked by clk and oversampling each bit 8x
//*===========================================================
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        baud_cnt <= 3'b0 ;
    else
        baud_cnt <= baud_cnt + 1'b1 ;
end

assign tx_clk = baud_cnt[2] ;

//*===========================================================
//* uart_tx instantiation
//*===========================================================
uart_tx uart_tx_inst ( .clk (tx_clk) ,
        .rst_n(rst_n) ,
        .p_data(p_data) ,
        .data_valid(data_valid),
        .par_en(par_en) ,
        .par_typ(par_typ) ,
        .tx_out(tx_out),
        .busy(busy)    );

//*===========================================================
//* uart_rx instantiation
//*===========================================================
uart_rx uart_rx_inst (.clk(clk) ,
        .rst_n (rst_n) ,
        .rx_in (rx_in) ,
        .par_en(par_en) ,
        .par_typ(par_typ),
        .p_data(rx_p_data) ,
        .data_valid(rx_data_valid) );

endmodule
