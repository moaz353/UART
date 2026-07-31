module uart_rx ( clk, rst_n, rx_in, par_en, par_typ, p_data, data_valid );

input wire clk  ; 
input wire rst_n ; 

input wire rx_in ; 

input wire par_en ; 

input wire par_typ ; 


output wire [10:0] p_data ; 

output wire data_valid ; 


//* uart_rx_counters_outputs signals  
wire [2:0] edge_cnt_top   ; 
wire [3:0] bit_cnt_top    ; 
wire [2:0] data_valid_cnt_top ; 


//* uart_rx_controller_outputs 
wire data_sampling_en_top ;
wire counter_en_top       ; 
wire par_chk_en_top       ;
wire stp_chk_en_top       ;
wire str_chk_en_top       ;
wire deser_en_top         ;
wire data_valid_top       ;     
wire cnt_zero_top         ; 
wire data_valid_par_chk_top ; 
wire data_valid_cnt_en_top  ; 
wire calc_par_bit_en_top   ; 

//* uart_rx_uart_rx_data_sampling_output 
wire sampled_bit_top ; 

//* uart_rx_parity_check_outputs 
wire par_err_top ; 
wire calc_par_bit_top ; 

//* uart_rx_start_check_outputs 
wire str_glitch_top ; 

//* uart_rx_stop_check_outputs 
wire stp_err_top ; 

//* uart_rx_deserializer_outputs 
wire [10:0] p_data_top ; 

//* Submodules instances ; 

uart_rx_controller uart_rx_controller_blk (.clk(clk),
            .rst_n(rst_n),
            .rx_in(rx_in),
            .bit_cnt(bit_cnt_top),
            .edge_cnt(edge_cnt_top),
            .str_glitch(str_glitch_top),
            .stp_err(stp_err_top),
            .par_err(par_err_top),
            .par_en(par_en),
            .data_valid_cnt(data_valid_cnt_top) ,
            .data_sampling_en(data_sampling_en_top),     //* output
            .counter_en(counter_en_top),                 //* output
            .cnt_zero(cnt_zero_top),                     //* output 
            .data_valid_par_chk(data_valid_par_chk_top), //* output
            .par_chk_en(par_chk_en_top),                 //* output
            .stp_chk_en(stp_chk_en_top),                 //* output
            .str_chk_en(str_chk_en_top),                 //* output
            .deser_en(deser_en_top),                     //* output
            .data_valid_cnt_en(data_valid_cnt_en_top),   //* output 
            .data_valid(data_valid_top),                 //* output
            .calc_par_bit_en(calc_par_bit_en_top)        //* output 
);


uart_rx_counters uart_rx_counters_blk (.clk(clk),
                                        .rst_n(rst_n),
                                        .enable(counter_en_top),
                                        .cnt_zero(cnt_zero_top),
                                        .data_valid_cnt_en(data_valid_cnt_en_top),
                                        .bit_cnt(bit_cnt_top),      //* output 
                                        .edge_cnt(edge_cnt_top),     //* output 
                                        .data_valid_cnt(data_valid_cnt_top) //*output 
);

uart_rx_data_sampling uart_rx_data_sampling_blk (.clk(clk),
                                    .rst_n(rst_n),
                                    .rx_in(rx_in),
                                    .data_samp_en(data_sampling_en_top),
                                    .edge_cnt(edge_cnt_top),       
                                    .bit_cnt(bit_cnt_top),
                                    .sampled_bit(sampled_bit_top)    //* output 
);

uart_rx_parity_check uart_rx_parity_check_blk (.clk(clk),
                                    .rst_n(rst_n),
                                    .par_typ(par_typ),
                                    .par_chk_en(par_chk_en_top),
                                    .sampled_bit(sampled_bit_top),
                                    .data_valid_par_chk(data_valid_par_chk_top),
                                    .edge_cnt(edge_cnt_top),      
                                    .calc_par_bit_en(calc_par_bit_en_top),
                                    .par_err(par_err_top),   //* output 
                                    .calc_par_bit(calc_par_bit_top) //* output
);

uart_rx_start_check uart_rx_start_check_blk (.clk(clk),
                            .rst_n(rst_n),
                            .sampled_bit(sampled_bit_top),
                            .str_chk_en(str_chk_en_top),
                            .str_glitch(str_glitch_top)      //* output 
);

uart_rx_stop_check uart_rx_stop_check_blk (.clk(clk),
                            .rst_n(rst_n),
                            .sampled_bit(sampled_bit_top),
                            .stp_chk_en(stp_chk_en_top),
                            .stp_err(stp_err_top)     //* output               
);


uart_rx_deserializer uart_rx_deserializer_blk (.clk(clk),
                                .rst_n(rst_n),
                                .deser_en(deser_en_top),
                                .sampled_bit(sampled_bit_top),
                                .bit_cnt(bit_cnt_top),
                                .edge_cnt(edge_cnt_top),
                                .par_en(par_en),
                                .data_valid(data_valid_top),
                                .calc_par_bit(calc_par_bit_top),
                                .p_data(p_data_top)        //* output
);


assign data_valid = data_valid_top ; 
assign p_data     = p_data_top ;


endmodule
