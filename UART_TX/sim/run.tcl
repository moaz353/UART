
#* Create the work library used by QuestaSim for compilation
vlib work

#* Compile the testbench and all RTL source files for the UART transmitter
vlog "uart_tx_tb.v"
vlog "../rtl/uart_tx.v"
vlog "../rtl/uart_tx_serializer.v"
vlog "../rtl/uart_tx_parity_bit.v"
vlog "../rtl/uart_tx_mux4x1.v"
vlog "../rtl/uart_tx_controller.v"

#* Start the simulation with the UART transmitter testbench
vsim -voptargs=+acc uart_tx_tb

#* Optional: load the waveform configuration file.
# do wave.do

#* Run the full simulation until all testbench events are completed
run -all
