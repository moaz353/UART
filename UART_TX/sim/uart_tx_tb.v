module uart_tx_tb ; 

reg       clk_tb ;
reg       rst_n_tb ;
reg [7:0] p_data_tb ;
reg       data_valid_tb ;
reg       par_en_tb ;
reg       par_typ_tb ;

wire      tx_out_tb ;
wire      busy_tb ;


//* Instantiate the DUT (Device Under Test)

uart_tx DUT (.clk(clk_tb) , 
                .rst_n(rst_n_tb) , 
                .p_data(p_data_tb) , 
                .data_valid(data_valid_tb) , 
                .par_en(par_en_tb) ,
                .par_typ(par_typ_tb) , 
                .tx_out(tx_out_tb) , 
                .busy(busy_tb)           ); 

initial begin
    clk_tb = 0 ; 
    forever #1 clk_tb =~clk_tb ; 
end


initial  begin 
    //* active rst_n_tb ; 
    rst_n_tb = 0 ;            

    @(negedge clk_tb) ;
    @(negedge clk_tb) ;  
    //* inactive rst_n_tb ;
    rst_n_tb = 1 ;
    
    //*====================================================
    //* TEST CASE 1
    //* Even Parity Transmission
    //* Data = 8'b0110_1110
    //*====================================================
    
    $display("\n==============================");
    $display("TEST CASE 1: EVEN PARITY");
    $display("==============================");
    
    p_data_tb = 8'b0110_1110 ;
    data_valid_tb = 1 ; 
    par_en_tb = 1 ; 
    par_typ_tb = 0 ; 
    @(negedge clk_tb ) ; 
    data_valid_tb = 0 ; 
    repeat(11) begin 
        @(negedge clk_tb ) ; 
    end
    $display("TEST CASE 1 COMPLETED");
    
    //*====================================================
    //* TEST CASE 2
    //* Odd Parity Transmission
    //* Data = 8'b0110_0010
    //*====================================================
    
    $display("\n==============================");
    $display("TEST CASE 2: ODD PARITY");
    $display("==============================");
    
    p_data_tb = 8'b0110_0010 ;
    data_valid_tb = 1 ; 
    par_en_tb = 1 ; 
    par_typ_tb = 1 ; 
    @(negedge clk_tb ) ; 
    data_valid_tb = 0 ; 
    repeat(11) begin 
        @(negedge clk_tb ) ; 
    end
    $display("TEST CASE 2 COMPLETED");
    
    
    //*====================================================
    //* TEST CASE 3
    //* No Parity
    //* Data = 8'b0100_1010
    //*====================================================
    
    $display("\n==============================");
    $display("TEST CASE 3: NO PARITY");
    $display("==============================");
    
    p_data_tb = 8'b0100_1010 ;
    data_valid_tb = 1 ; 
    par_en_tb = 0 ; 
    par_typ_tb = 0 ; 
    @(negedge clk_tb ) ; 
    data_valid_tb = 0 ; 
    repeat(11) begin 
        @(negedge clk_tb ) ; 
    end
    $display("TEST CASE 3 COMPLETED");
    
    //*====================================================
    //* TEST CASE 4
    //* No Parity
    //* Data = 8'b0001_1100
    //*====================================================
    
    $display("\n==============================");
    $display("TEST CASE 4: NO PARITY");
    $display("=============================="); 
    
    p_data_tb = 8'b0001_1100 ;
    data_valid_tb = 1 ; 
    par_en_tb = 0 ; 
    par_typ_tb = 1 ; 
    @(negedge clk_tb ) ; 
    data_valid_tb = 0 ; 
    repeat(11) begin 
        @(negedge clk_tb ) ; 
    end
    $display("TEST CASE 4 COMPLETED");
    
    //*====================================================
    //* TEST CASE 5
    //* data_valid_tb = 0
    //*====================================================
    
    $display("\n==============================");
    $display("TEST CASE 5: DATA VALID DISABLED");
    $display("==============================");
    
    p_data_tb = 8'b0011_1110 ;
    data_valid_tb = 0 ; 
    par_en_tb = 0 ; 
    par_typ_tb = 1 ; 
    @(negedge clk_tb ) ; 
    data_valid_tb = 0 ; 
    repeat(11) begin 
        @(negedge clk_tb ) ; 
    end
    $display("TEST CASE 5 COMPLETED");
    
    //*====================================================
    //* TEST CASE 6
    //* data_valid_tb = 0 with parity enabled
    //*====================================================
    
    $display("\n==============================");
    $display("TEST CASE 6: DATA VALID DISABLED WITH PARITY");
    $display("==============================");
    
    p_data_tb = 8'b0011_1110 ;
    data_valid_tb = 0 ; 
    par_en_tb = 1 ; 
    par_typ_tb = 1 ; 
    @(negedge clk_tb ) ; 
    data_valid_tb = 0 ; 
    repeat(11) begin 
        @(negedge clk_tb ) ; 
    end
    $display("TEST CASE 6 COMPLETED");

$stop ; 

end 

endmodule