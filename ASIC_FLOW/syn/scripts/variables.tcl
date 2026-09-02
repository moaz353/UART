###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Synthesis-specific variables. 
#
# Flow Stage  : Syn
#
# Dependencies: common/variables.tcl
#
###############################################################################
##################### SYN Dirs define #########################################

set SYN_REPORT_DIR            "${ROOT_DIR}/syn/reports"
set SYN_QOR_DIR               "${SYN_REPORT_DIR}/qor"
set SYN_OUTPUT_DIR            "${ROOT_DIR}/syn/output"

# ###########################################################################
# 1. Compile strategy
# ###########################################################################
# One of : timing | area | power
# The strategies are implemented in compile_strategies.tcl.

set COMPILE_STRATEGY "timing"

# ###########################################################################
# 2. RTL file list
# ###########################################################################
# (leaf modules first, top module last): rtl_rx files , rtl_tx files , uart_warper .

set RTL_FILES {
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_rx/uart_rx_controller.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_rx/uart_rx_counters.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_rx/uart_rx_data_sampling.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_rx/uart_rx_deserializer.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_rx/uart_rx_parity_check.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_rx/uart_rx_start_check.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_rx/uart_rx_stop_check.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_rx/uart_rx.v"
    
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_tx/uart_tx_controller.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_tx/uart_tx_mux4x1.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_tx/uart_tx_parity_bit.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_tx/uart_tx_serializer.v"
    "/home/ICer/Mo_AZ/UART_Project/rtl/rtl_tx/uart_tx.v"
    
    "/home/ICer/Mo_AZ/UART_Project/rtl/uart.v"
}

# ###########################################################################
# 3. Output file names (synthesis results)
# ###########################################################################
set SYN_NETLIST         "${SYN_OUTPUT_DIR}/${DESIGN_NAME}_netlist.v"
set SYN_DDC             "${SYN_OUTPUT_DIR}/${DESIGN_NAME}.ddc"
set SYN_SDC             "${SYN_OUTPUT_DIR}/${DESIGN_NAME}_output.sdc"
set SYN_SDF             "${SYN_OUTPUT_DIR}/${DESIGN_NAME}.sdf"

###############################################################################
# End of file
###############################################################################
