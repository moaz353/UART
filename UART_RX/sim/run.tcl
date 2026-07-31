quit -sim

vlib work

#* compile verilog design files 
vlog "../rtl/uart_rx_counters.v"
vlog "../rtl/uart_rx_data_sampling.v"
vlog "../rtl/uart_rx_deserializer.v"
vlog "../rtl/uart_rx_parity_check.v"
vlog "../rtl/uart_rx_start_check.v"
vlog "../rtl/uart_rx_stop_check.v"
vlog "../rtl/uart_rx_controller.v"
vlog "../rtl/uart_rx_top.v"
#* compile sv testbench file 
vlog -sv "./uart_rx_tb.sv"   

#* start sim with testbench module 
vsim -voptargs=+acc uart_rx_tb

# add wave *

do wave.do 

run -all
