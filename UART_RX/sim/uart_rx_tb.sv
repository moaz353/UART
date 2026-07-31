module uart_rx_tb ();

logic clk_tb  ; 
logic rst_n_tb ; 

logic rx_in_tb ; 
logic par_en_tb ; 
logic par_typ_tb ; 

logic [10:0] p_data_tb ; 
logic data_valid_tb ; 

uart_rx uut (.clk(clk_tb), 
                .rst_n(rst_n_tb), 
                .rx_in(rx_in_tb), 
                .par_en(par_en_tb), 
                .par_typ(par_typ_tb), 
                .p_data(p_data_tb), 
                .data_valid(data_valid_tb) );



task automatic send_frame_with_par( input logic str_bit_t , input logic [7:0] data_byte_t , input logic parity_bit_t , input logic stp_bit_t );
    int i;
    
    rx_in_tb = str_bit_t;
    repeat(8) @(negedge clk_tb);
    
    for (i = 0; i < 8; i++) begin
        rx_in_tb = data_byte_t[i];
        repeat(8) @(negedge clk_tb);
    end
    
    rx_in_tb = parity_bit_t;
    repeat(8) @(negedge clk_tb);
    
    rx_in_tb = stp_bit_t;
    repeat(8) @(negedge clk_tb);
    
endtask

task automatic send_frame_without_par( input logic str_bit_t , input logic [7:0] data_byte_t , input logic stp_bit_t );
    int i;
    
    rx_in_tb = str_bit_t;
    repeat(8) @(negedge clk_tb);
    
    for (i = 0; i < 8; i++) begin
        rx_in_tb = data_byte_t[i];
        repeat(8) @(negedge clk_tb);
    end
    
    rx_in_tb = stp_bit_t;
    repeat(8) @(negedge clk_tb);
    
endtask



initial begin 
    clk_tb = 0 ; 
    forever #1 clk_tb = ~clk_tb ; 
end


initial begin 

    rst_n_tb = 0 ; 
    @(negedge clk_tb) ; 
    
    rst_n_tb = 1 ; 
    
//******* test_case_1  -> check the str_glitch. 
    par_en_tb = 1 ; 
    par_typ_tb = 0 ; //* even par ; 
    
    rx_in_tb = 0 ; 
    @(negedge clk_tb) ; 
    rx_in_tb = 1 ; 
    repeat(20)
        @(negedge clk_tb) ; 
    
//******* test_case_2  -> with par bit , even par ; 
    par_en_tb = 1 ; 
    par_typ_tb = 0 ; //* even par ; 
    send_frame_with_par(1'b0 , 8'b0110_1011 , 1'b1 , 1'b1 ) ;  //* correct frame to test the process ; 
    
    repeat (18) 
    @(negedge clk_tb) ; 

//******* test_case_3  -> with par bit , even par ; 
    par_en_tb = 1 ; 
    par_typ_tb = 0 ; //* even par ; 
    send_frame_with_par(1'b0 , 8'b0110_1011 , 1'b0 , 1'b1 ) ;  //* wrong parity bit to test the process ; 
    
    repeat (20) 
    @(negedge clk_tb) ; 
    
//******* test_case_4  -> with par bit , odd par ; 
    par_en_tb = 1 ; 
    par_typ_tb = 1 ; //* odd par ; 
    send_frame_with_par(1'b0 , 8'b0110_1011 , 1'b0 , 1'b1 ) ;  //* correct parity bit to test the process ; 
    
    repeat (20) 
    @(negedge clk_tb) ; 
    
//******* test_case_5  -> with par bit , odd par ; 
    par_en_tb = 1 ; 
    par_typ_tb = 1 ; //* odd par ; 
    send_frame_with_par(1'b0 , 8'b0110_1011 , 1'b1 , 1'b1 ) ;  //* wrong parity bit to test the process ; 
    
    repeat (20) 
    @(negedge clk_tb) ; 
    
//******* test_case_6  -> with par bit , odd par ; 
    par_en_tb = 0 ; 
    par_typ_tb = 1 ; //* odd par ; 
    send_frame_without_par(1'b0 , 8'b0110_1011  , 1'b1 ) ;  //* no parity bit to test the process ; 
    
    repeat (20) 
    @(negedge clk_tb) ; 
    
//******* test_case_7  -> check again the str_glitch. 
    rx_in_tb = 0 ; 
    @(negedge clk_tb) ; 
    rx_in_tb = 1 ; 
    repeat(20)
        @(negedge clk_tb) ; 

$stop ; 

end

endmodule 
