###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Formality-specific variables.
#
###############################################################################

set DESIGN_NAME "uart"

set FM_REPORT_DIR            "${SCRIPT_DIR}/../reports"

# ###########################################################################
# 1. Reference (RTL) container inputs
# ###########################################################################
# RTL files of the golden design. List them explicitly so the FM flow does
# not depend on a side file.
set FM_RTL_FILES {
    "/home/IC/Mo_AZ/uart/rtl/rtl_rx/uart_rx_controller.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_rx/uart_rx_counters.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_rx/uart_rx_data_sampling.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_rx/uart_rx_deserializer.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_rx/uart_rx_parity_check.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_rx/uart_rx_start_check.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_rx/uart_rx_stop_check.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_rx/uart_rx.v"
    
    "/home/IC/Mo_AZ/uart/rtl/rtl_tx/uart_tx_controller.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_tx/uart_tx_mux4x1.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_tx/uart_tx_parity_bit.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_tx/uart_tx_serializer.v"
    "/home/IC/Mo_AZ/uart/rtl/rtl_tx/uart_tx.v"
    
    "/home/IC/Mo_AZ/uart/rtl/uart.v"
}

# ###########################################################################
# 2. Implementation (netlist) container inputs
# ###########################################################################
# Gate-level netlist produced by DC (see syn/save_outputs.tcl).
set FM_NETLIST  "${COMMON_DIR}/req_files/uart_netlist.v"

# Liberty views used by both containers (selected corners from
# library_selection.tcl).
set FM_LIBS     "/home/IC/Mo_AZ/Common/hierar_NDM_sead_32/SAED32/STD/saed32rvt_tt1p05v25c.db"

# ###########################################################################
# 3. SVF (produced by the DC compile session)
# ###########################################################################
set FM_SVF      "${COMMON_DIR}/req_files/uart_fm.svf"

###############################################################################
# End of file
###############################################################################
