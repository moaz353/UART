################################################################################
#
# Design name:  temp_place_ends
#
# Created by icc2 write_sdc on Mon Aug 31 20:36:21 2026
#
################################################################################

set sdc_version 2.1
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: func
# Corner: slow
# Scenario: func_slow

# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 41; \
#   /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 42; \
#   /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 42
create_clock -name sys_clk -period 10 -waveform {0 5} [get_ports {clk}]
set_propagated_clock [get_clocks {sys_clk}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 49; \
#   /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 49
group_path -name COMBO -from [get_ports {clk rst_n p_data[7] p_data[6] \
    p_data[5] p_data[4] p_data[3] p_data[2] p_data[1] p_data[0] data_valid \
    par_en par_typ rx_in}] -to [get_ports {tx_out busy rx_p_data[10] \
    rx_p_data[9] rx_p_data[8] rx_p_data[7] rx_p_data[6] rx_p_data[5] \
    rx_p_data[4] rx_p_data[3] rx_p_data[2] rx_p_data[1] rx_p_data[0] rx_data_valid}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 50; \
#   /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 50
group_path -name INPUT -from [get_ports {clk rst_n p_data[7] p_data[6] \
    p_data[5] p_data[4] p_data[3] p_data[2] p_data[1] p_data[0] data_valid \
    par_en par_typ rx_in}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 51; \
#   /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 51
group_path -name OUTPUT -to [get_ports {tx_out busy rx_p_data[10] rx_p_data[9] \
    rx_p_data[8] rx_p_data[7] rx_p_data[6] rx_p_data[5] rx_p_data[4] \
    rx_p_data[3] rx_p_data[2] rx_p_data[1] rx_p_data[0] rx_data_valid}]
set_load -pin_load 0.02 [get_ports {tx_out}]
set_load -pin_load 0.02 [get_ports {busy}]
set_load -pin_load 0.02 [get_ports {rx_p_data[10]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[9]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[8]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[7]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[6]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[5]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[4]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[3]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[2]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[1]}]
set_load -pin_load 0.02 [get_ports {rx_p_data[0]}]
set_load -pin_load 0.02 [get_ports {rx_data_valid}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 9
set_operating_conditions -analysis_type on_chip_variation -max ss0p95v125c -min \
    ff1p16vn40c -max_library saed32rvt_ss0p95v125c -min_library \
    saed32rvt_ff1p16vn40c
# Set latency for io paths.
# -origin user
set_clock_latency -min 0.00394822 [get_clocks {sys_clk}]
# -origin user
set_clock_latency -max 0.00425339 [get_clocks {sys_clk}]
# Set propagated on clock sources to avoid removing latency for IO paths.
set_propagated_clock  [get_ports {clk}]
set_clock_uncertainty -setup 0.2 [get_clocks {sys_clk}]
set_clock_uncertainty -hold 0.1 [get_clocks {sys_clk}]
set_clock_transition 0.05 [get_clocks {sys_clk}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 14
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {rst_n}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 15
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {p_data[7]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 16
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {p_data[6]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 17
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {p_data[5]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 18
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {p_data[4]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 19
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {p_data[3]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 20
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {p_data[2]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 21
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {p_data[1]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 22
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {p_data[0]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 23
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {data_valid}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 24
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {par_en}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 25
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {par_typ}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 26
set_driving_cell -lib_cell IBUFFX2_RVT -pin Y -library saed32rvt_tt1p05v25c \
    [get_ports {rx_in}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 52
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rst_n}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 53
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {p_data[7]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 54
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {p_data[6]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 55
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {p_data[5]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 56
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {p_data[4]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 57
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {p_data[3]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 58
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {p_data[2]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 59
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {p_data[1]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 60
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {p_data[0]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 61
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {data_valid}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 62
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {par_en}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 63
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {par_typ}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 65
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {tx_out}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 66
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {busy}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 64
set_input_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_in}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 67
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[10]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 68
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[9]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 69
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[8]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 70
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[7]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 71
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[6]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 72
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[5]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 73
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[4]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 74
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[3]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 75
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[2]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 76
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[1]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 77
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_p_data[0]}]
# /home/ICer/Mo_AZ/UART_Project/syn/output/uart_output.sdc, line 78
set_output_delay -clock [get_clocks {sys_clk}] 2 [get_ports {rx_data_valid}]
set_max_transition 0.5 [current_design]
