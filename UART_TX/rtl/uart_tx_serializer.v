module uart_tx_serializer (clk , rst_n , p_data , ser_en , ser_done , ser_data); 

input       clk ; 
input       rst_n ; 

input [7:0] p_data   ; 
input       ser_en   ; 

output reg      ser_done ; 
output reg      ser_data ; 

reg [2:0] ser_counter ; 


always@(posedge clk or negedge rst_n) begin 

    if(~rst_n) begin  
        ser_counter  <= 0 ; 
        ser_data     <= 0 ; 
    end
    else begin 
        if (ser_en) begin 
            ser_data <= p_data[ser_counter] ; 
            ser_counter <= ser_counter + 1 ;  
        end
        else  begin
            ser_counter <= 0 ; 
            ser_data <= 1 ; 
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) 
        ser_done <= 0 ; 
    else begin 
        if (ser_counter == 7 )  
            ser_done <= 1 ; 
        else 
            ser_done <= 0 ; 
        end
end
endmodule
