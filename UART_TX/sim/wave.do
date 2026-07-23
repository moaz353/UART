onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_tx_tb/DUT/clk
add wave -noupdate /uart_tx_tb/DUT/rst_n
add wave -noupdate -radix binary /uart_tx_tb/DUT/p_data
add wave -noupdate /uart_tx_tb/DUT/data_valid
add wave -noupdate /uart_tx_tb/DUT/par_en
add wave -noupdate /uart_tx_tb/DUT/par_typ
add wave -noupdate -color {Violet Red} /uart_tx_tb/DUT/tx_out
add wave -noupdate /uart_tx_tb/DUT/busy
add wave -noupdate -divider -height 25 {FSM States}
add wave -noupdate /uart_tx_tb/DUT/uart_tx_controller_mod/state
add wave -noupdate /uart_tx_tb/DUT/uart_tx_controller_mod/next_state
add wave -noupdate -divider -height 25 Controller-signals
add wave -noupdate /uart_tx_tb/DUT/uart_tx_controller_mod/mux_sel
add wave -noupdate /uart_tx_tb/DUT/uart_tx_controller_mod/busy
add wave -noupdate -divider -height 25 Serializer_Signals
add wave -noupdate /uart_tx_tb/DUT/uart_tx_serializer_mod/ser_en
add wave -noupdate /uart_tx_tb/DUT/uart_tx_serializer_mod/ser_done
add wave -noupdate -color {Violet Red} /uart_tx_tb/DUT/uart_tx_serializer_mod/ser_data
add wave -noupdate /uart_tx_tb/DUT/uart_tx_serializer_mod/ser_counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {90 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {62 ns} {188 ns}
