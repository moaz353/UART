onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider control_s
add wave -noupdate /uart_rx_tb/clk_tb
add wave -noupdate /uart_rx_tb/rst_n_tb
add wave -noupdate /uart_rx_tb/par_en_tb
add wave -noupdate /uart_rx_tb/par_typ_tb
add wave -noupdate -divider Input_S
add wave -noupdate /uart_rx_tb/rx_in_tb
add wave -noupdate -divider Output_S
add wave -noupdate -radix binary /uart_rx_tb/p_data_tb
add wave -noupdate /uart_rx_tb/data_valid_tb
add wave -noupdate -divider Counters
add wave -noupdate -color {Orange Red} /uart_rx_tb/uut/edge_cnt_top
add wave -noupdate -color {Orange Red} -radix unsigned /uart_rx_tb/uut/bit_cnt_top
add wave -noupdate -color {Orange Red} /uart_rx_tb/uut/data_valid_cnt_top
add wave -noupdate -divider Control_Enables_S
add wave -noupdate -color {Orange Red} /uart_rx_tb/uut/counter_en_top
add wave -noupdate -color {Orange Red} /uart_rx_tb/uut/data_valid_cnt_en_top
add wave -noupdate -color {Orange Red} /uart_rx_tb/uut/cnt_zero_top
add wave -noupdate -color Yellow /uart_rx_tb/uut/data_sampling_en_top
add wave -noupdate -color Magenta /uart_rx_tb/uut/str_chk_en_top
add wave -noupdate -color {Steel Blue} /uart_rx_tb/uut/par_chk_en_top
add wave -noupdate -color {Steel Blue} /uart_rx_tb/uut/data_valid_par_chk_top
add wave -noupdate -color {Dark Orchid} /uart_rx_tb/uut/stp_chk_en_top
add wave -noupdate -color Cyan /uart_rx_tb/uut/deser_en_top
add wave -noupdate -color Cyan /uart_rx_tb/uut/data_valid_top
add wave -noupdate -divider Str_check_out
add wave -noupdate -color Magenta /uart_rx_tb/uut/str_glitch_top
add wave -noupdate -divider uart_rx_data_sampling_out
add wave -noupdate -color Yellow /uart_rx_tb/uut/uart_rx_data_sampling_blk/three_samps_data
add wave -noupdate -color Yellow /uart_rx_tb/uut/sampled_bit_top
add wave -noupdate -divider Par_check_out
add wave -noupdate -color {Steel Blue} /uart_rx_tb/uut/par_err_top
add wave -noupdate -color {Steel Blue} /uart_rx_tb/uut/calc_par_bit_top
add wave -noupdate -divider Stp_check_out
add wave -noupdate -color {Dark Orchid} /uart_rx_tb/uut/stp_err_top
add wave -noupdate -divider Deser_out
add wave -noupdate -radix binary /uart_rx_tb/uut/p_data_top
add wave -noupdate -divider FSM_States
add wave -noupdate /uart_rx_tb/uut/uart_rx_controller_blk/state
add wave -noupdate /uart_rx_tb/uut/uart_rx_controller_blk/next_state
add wave -noupdate -divider Deserializer_S
add wave -noupdate -color Cyan -radix binary /uart_rx_tb/uut/uart_rx_deserializer_blk/p_data
add wave -noupdate -color Cyan -radix binary /uart_rx_tb/uut/uart_rx_deserializer_blk/p_data_temp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1000 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
configure wave -valuecolwidth 160
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {966 ns} {1156 ns}
