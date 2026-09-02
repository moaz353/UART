module uart_rx_controller (clk , rst_n , rx_in , bit_cnt , edge_cnt , str_glitch , stp_err , par_err , par_en ,
                            data_sampling_en , counter_en , cnt_zero ,  par_chk_en , stp_chk_en , str_chk_en ,  
                            deser_en , data_valid_cnt_en , data_valid_cnt , calc_par_bit_en , data_valid , data_valid_par_chk ); 

//*states
parameter IDLE            = 3'b000 ;
parameter START_CHECK      = 3'b001 ;
parameter DATA_PROCESS     = 3'b010 ;
parameter PAR_CHECK        = 3'b011 ;
parameter STP_CHECK        = 3'b100 ;
parameter DATA_OUT         = 3'b101 ;

//*input ports

input        clk        ; 
input        rst_n      ; 

input        rx_in      ; 

input  [3:0] bit_cnt          ; 
input  [2:0] edge_cnt         ;
input  [2:0] data_valid_cnt   ;

input        str_glitch ;
input        par_err    ;
input        par_en     ;
input        stp_err    ;


//*output ports 
output reg  data_sampling_en ; 
output reg  counter_en       ; 
output reg  cnt_zero     ;   
output reg  par_chk_en       ; 
output reg  stp_chk_en       ; 
output reg  str_chk_en       ;  
output reg  deser_en         ; 
output reg  data_valid       ; 
output reg  data_valid_par_chk ;
output reg  data_valid_cnt_en ;
output reg  calc_par_bit_en ;


//* internal signals 

reg [2:0] state      ; 
reg [2:0] next_state ; 

//******************************* state register 
always @(posedge clk ) begin
    if(~rst_n) 
        state <= 3'b0 ; 
    else 
        state <= next_state ; 
end

//******************************* state transition logic 
always@(*) begin 
    if(~rst_n) 
        next_state = IDLE ; 
    else begin 
        case(state) 
            IDLE         : begin 
                if(~rx_in )
                    next_state = START_CHECK ; 
                else
                    next_state = IDLE ; 
            end 
            
            START_CHECK   : begin 
                if (str_glitch && bit_cnt == 2 && edge_cnt == 0 ) //* edge counts 8 and increase bit_cnt by 1 ;  
                                                                  //* make sure start_check state take a 8 cycles with edge_  
                                                                  //* counter to check the rx_in bit by oversampling ; 
                    next_state = IDLE ; 
                else begin 
                    if (~str_glitch && bit_cnt == 2 && edge_cnt == 0 )
                        next_state = DATA_PROCESS ; 
                    else 
                        next_state = START_CHECK ; 
                end 
            end
            DATA_PROCESS  : begin 
                if (~par_en && bit_cnt == 10) 
                    next_state = STP_CHECK ; 
                else if (par_en && bit_cnt == 10)
                    next_state = PAR_CHECK ; 
                else 
                    next_state = DATA_PROCESS ; 
            end 
            
            PAR_CHECK     : begin 
                if (~par_err && edge_cnt == 0 && bit_cnt == 11) 
                    next_state = STP_CHECK ; 
                else if (par_err) 
                    next_state = IDLE ; 
                else 
                    next_state = PAR_CHECK ; 
            end 
            
            STP_CHECK     : begin 
                if (~stp_err && edge_cnt == 0 && ( bit_cnt == 12 || bit_cnt == 11 ) )  //* (12||11) if there is not parity bit .   
                    next_state = DATA_OUT ; 
                else if (stp_err)
                    next_state = IDLE ; 
                else 
                    next_state = STP_CHECK ; 
            end 
            
            DATA_OUT      : begin 
                if (data_valid_cnt == 7 ) 
                    next_state = IDLE ; 
                else 
                    next_state = DATA_OUT ; 
            end 
            
            default      : begin 
            next_state = IDLE ; 
            end 
        endcase 
    end
end 

//************************* state output logic
always@(*) begin 
        case(state) 
            IDLE         : begin 
                data_sampling_en   = 0  ;  
                counter_en         = 0  ;   
                str_chk_en         = 0  ;      
                deser_en           = 0  ;   
                par_chk_en         = 0  ; 
                stp_chk_en         = 0  ; 
                data_valid         = 0  ; 
                cnt_zero           = 1  ;  //* Reset bit and edge counters
                data_valid_par_chk = 0  ;
                data_valid_cnt_en  = 0  ; 
                calc_par_bit_en    = 0  ; 
            end 
            
            START_CHECK   : begin 
                data_sampling_en   = 1  ;  //* enable to sample the bit to check if start bit or glitch 
                counter_en         = 1  ;  //* enable to start count edges for sampling
                str_chk_en         = 1  ;  //* enable to check the start bit into START_CHECK state 
                deser_en           = 0  ;   
                par_chk_en         = 0  ; 
                stp_chk_en         = 0  ; 
                data_valid         = 0  ;
                cnt_zero           = 0  ;
                data_valid_par_chk = 0  ;
                data_valid_cnt_en  = 0  ; 
                calc_par_bit_en    = 0  ; 
            end 
            
            DATA_PROCESS : begin 
                data_sampling_en   = 1  ; //* enable to sample the data bits   
                counter_en         = 1  ; 
                str_chk_en         = 0  ;   
                deser_en           = 1  ; //* enable to start deserializer the frame data ;
                par_chk_en         = 0  ; 
                stp_chk_en         = 0  ; 
                data_valid         = 0  ; 
                cnt_zero           = 0  ;
                data_valid_par_chk = 1  ; //* enable parity calculation for received data 
                data_valid_cnt_en  = 0  ; 
                calc_par_bit_en    = 1  ; //* refresh calculated parity bit based on selected parity type
            end 
            
            PAR_CHECK    : begin 
                data_sampling_en   = 1  ; 
                counter_en         = 1  ; 
                str_chk_en         = 0  ;   
                deser_en           = 0  ; 
                par_chk_en         = 1  ; //* enable comparison between calculated and received parity bits
                stp_chk_en         = 0  ; 
                data_valid         = 0  ; 
                cnt_zero           = 0  ;
                data_valid_par_chk = 0  ;
                data_valid_cnt_en  = 0  ; 
                calc_par_bit_en    = 1  ; 
            end 
            
            STP_CHECK    : begin 
                data_sampling_en   = 1  ; 
                counter_en         = 1  ; 
                str_chk_en         = 0  ;   
                deser_en           = 0  ; 
                par_chk_en         = 0  ; 
                stp_chk_en         = 1  ; //* enable to check the stop bit 
                data_valid         = 0  ; 
                cnt_zero           = 0  ;  
                data_valid_par_chk = 0  ;
                data_valid_cnt_en  = 0  ; 
                calc_par_bit_en    = 1  ; 
            end 
            DATA_OUT     : begin 
                data_sampling_en   = 0  ; 
                counter_en         = 0  ; 
                str_chk_en         = 0  ;   
                deser_en           = 0  ; 
                par_chk_en         = 0  ; 
                stp_chk_en         = 0  ; 
                data_valid         = 1  ; 
                cnt_zero           = 1  ; //* to reset bit counter after finish ;
                data_valid_par_chk = 0  ;
                data_valid_cnt_en  = 1  ; //* enable to count 8 cycles during DATA_OUT state before transitioning to IDLE
                calc_par_bit_en    = 1  ;  
            end 
            default        : begin 
                data_sampling_en   = 0  ; 
                counter_en         = 0  ; 
                str_chk_en         = 0  ;   
                deser_en           = 0  ; 
                par_chk_en         = 0  ; 
                stp_chk_en         = 0  ; 
                data_valid         = 0  ;
                cnt_zero           = 0  ;
                data_valid_par_chk = 0  ;
                data_valid_cnt_en  = 0  ; 
                calc_par_bit_en    = 0  ; 
            end 
        endcase 
end 

endmodule 