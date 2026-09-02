module uart_tx_controller (clk , rst_n , data_valid ,par_en , ser_done ,
                            mux_sel , busy , ser_en); 

//*states
parameter IDEAL         = 3'b000 ;
parameter START         = 3'b001 ;
parameter PARALLEL_DATA = 3'b010 ;
parameter PARITY_BIT    = 3'b011 ;
parameter STOP          = 3'b100 ;

//*input ports
input        clk        ; 
input        rst_n      ; 
input        data_valid ; 
input        par_en     ; 
input        ser_done   ; 

//*output ports 
output reg  [1:0] mux_sel    ; 
output reg        busy       ; 
output reg        ser_en     ; 

//* internal signals 
reg [2:0] state      ; 
reg [2:0] next_state ; 

//*state mem 
always @(posedge clk ) begin
    if(~rst_n) 
        state <= 0 ; 
    else 
        state <= next_state ; 
end

//*state transitions 
always@(*) begin 
    if(~rst_n) 
        next_state = IDEAL ; 
    else begin 
        case(state) 
        IDEAL         : begin 
                if(data_valid) 
                    next_state = START ; 
                else 
                    next_state = IDEAL ; 
        end 
        
        START         : begin 
                if(~data_valid) 
                    next_state = PARALLEL_DATA ; 
                else 
                    next_state = START ; 
        end 
        
        PARALLEL_DATA : begin 
            if(~data_valid ) begin 
                if(ser_done) begin
                    if(par_en) 
                        next_state = PARITY_BIT ; 
                    else 
                        next_state = STOP       ; 
                end
                else 
                    next_state = PARALLEL_DATA ; 
            end 
            else 
                next_state = PARALLEL_DATA ; 
        end 
        
        PARITY_BIT    : begin 
            if(~data_valid) 
                next_state = STOP ; 
            else 
                next_state = PARITY_BIT ; 
        end 
        
        STOP          : begin 
            if(~data_valid) 
                next_state = IDEAL ; 
            else 
                next_state = STOP  ;  
        end 
        
        default       : begin 
            next_state = IDEAL ; 
        end 
        endcase 
    end
end 

//* state outputs 
always@(*) begin 
    if(~rst_n) begin 
        mux_sel = 2'b01 ;  
        busy    = 0 ; 
        ser_en  = 0 ;
    end
    else begin 
        case(state) 
            IDEAL          : begin 
                busy    = 0         ;
                mux_sel = 2'b01     ;   //* stop bit  = 1 ; 
                ser_en  = 0         ; 
            end 

            START         : begin 
                busy    = 1         ;   
                mux_sel = 2'b00     ;   //* start bit = 0 ; 
                ser_en  = 1         ; 
            end 
        
            PARALLEL_DATA : begin 
                busy    = 1         ; 
                mux_sel = 2'b10     ;  //* ser_data (8 clk cycle for 8 bits ) ; 
                                       //* output of serializer module ; 
                ser_en  = 1         ; 
            end 
        
            PARITY_BIT    : begin 
                busy    = 1         ;        
                mux_sel = 2'b11     ;  //* parity bit  = input of parity bit calc module 
                ser_en  = 0         ; 
            end 
        
            STOP           : begin 
                busy    = 1         ;  
                mux_sel = 2'b01     ;  //* stop bit = 1 ; 
                ser_en  = 0         ; 
            end 
        
            default        : begin 
                busy    = 0         ; 
                mux_sel = 2'b01     ;  //* stop bit = 1 ; 
                ser_en  = 0         ; 
            end 
            endcase 
    end
end 

endmodule 