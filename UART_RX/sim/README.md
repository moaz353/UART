# Simulation

ModelSim-based simulation for the UART_RX design.

---

## Simulator

**Mentor Graphics ModelSim** (Intel FPGA Edition)

---

## Files

| File | Description |
|------|-------------|
| `uart_rx_tb.sv` | SystemVerilog testbench with 7 directed test cases |
| `run.tcl` | ModelSim compilation and run script |
| `wave.do` | Waveform configuration (signal grouping and colors) |
| `waveforms/` | Captured waveform images |

---

## How to Run

### Method 1: Tcl Script

```tcl
# In ModelSim console, navigate to the sim/ directory:
do run.tcl
```

### Method 2: Manual Steps

```tcl
quit -sim
vlib work
vlog "../rtl/uart_rx_counters.v"
vlog "../rtl/uart_rx_data_sampling.v"
vlog "../rtl/uart_rx_deserializer.v"
vlog "../rtl/uart_rx_parity_check.v"
vlog "../rtl/uart_rx_start_check.v"
vlog "../rtl/uart_rx_stop_check.v"
vlog "../rtl/uart_rx_controller.v"
vlog "../rtl/uart_rx_top.v"
vlog -sv "./uart_rx_tb.sv"
vsim -voptargs=+acc uart_rx_tb
run -all
```

### Waveform Viewing

After simulation, load the waveform configuration:

```tcl
do wave.do
```

This configures the wave viewer with signal groups:
- **control_s**: clk_tb, rst_n_tb, par_en_tb, par_typ_tb
- **Input_S**: rx_in_tb
- **Output_S**: p_data_tb, data_valid_tb
- **Counters**: edge_cnt_top, bit_cnt_top, data_valid_cnt_top
- **Control_Enables_S**: counter_en_top, data_valid_cnt_en_top, cnt_zero_top, data_sampling_en_top, str_chk_en_top, par_chk_en_top, data_valid_par_chk_top, stp_chk_en_top, deser_en_top, data_valid_top
- **Str_check_out**: str_glitch_top
- **uart_rx_data_sampling_out**: three_samps_data, sampled_bit_top
- **Par_check_out**: par_err_top, calc_par_bit_top
- **Stp_check_out**: stp_err_top
- **Deser_out**: p_data_top
- **FSM_States**: state, next_state
- **Deserializer_S**: p_data, p_data_temp

---

## Testbench Strategy

The testbench (`uart_rx_tb.sv`) is a directed SystemVerilog testbench that applies **7 test cases** sequentially. It drives frames on `rx_in_tb` using two tasks:

- `send_frame_with_par(start, data_byte, parity, stop)`: drives a full 11-bit frame with parity (start, 8 data bits LSB-first, parity bit, stop bit), 8 clock cycles per bit.
- `send_frame_without_par(start, data_byte, stop)`: drives a 10-bit frame without parity, 8 clock cycles per bit.

All frame transitions are timed on the **negedge of the clock** (`rx_in_tb` changes at `@(negedge clk_tb)`), and each bit is held for exactly 8 clock cycles to match the receiver's 8x oversampling.

The clock period is 2 ns (`forever #1 clk_tb = ~clk_tb`) for fast simulation. The simulation ends with `$stop`; run the waveform viewer and the run script, then inspect each test case.

### Test Cases

All test cases use data byte `8'b0110_1011` (0x6B), which contains **5 ones** (odd count).

| # | `PAR_EN` | `PAR_TYP` | Frame Driven | Description |
|---|----------|-----------|--------------|-------------|
| 1 | 1 | 0 | `rx_in` low for 1 cycle, then high | Start glitch rejection. `STR_GLITCH` asserted, no frame processed. |
| 2 | 1 | 0 | `0` / `0x6B` / parity=`1` / `1` | Correct frame with even parity. 5 ones -> parity = 1. Full reception. |
| 3 | 1 | 0 | `0` / `0x6B` / parity=`0` / `1` | Wrong parity bit with even parity. `PAR_ERR` asserted, frame discarded. |
| 4 | 1 | 1 | `0` / `0x6B` / parity=`0` / `1` | Correct frame with odd parity. 5 ones -> parity = 0. Full reception. |
| 5 | 1 | 1 | `0` / `0x6B` / parity=`1` / `1` | Wrong parity bit with odd parity. `PAR_ERR` asserted, frame discarded. |
| 6 | 0 | 1 | `0` / `0x6B` / `1` | No parity frame. 10-bit reception, parity type irrelevant. |
| 7 | 1 | 0 | `rx_in` low for 1 cycle, then high | Start glitch rejection repeated. No frame processed. |

### Coverage

| Mode | Test Cases |
|------|------------|
| Start glitch rejection | TC1, TC7 |
| Even parity, correct frame | TC2 |
| Even parity, parity error | TC3 |
| Odd parity, correct frame | TC4 |
| Odd parity, parity error | TC5 |
| No parity reception | TC6 |
| Parity enabled + disabled | TC2-TC5 (enabled), TC6 (disabled) |
| `DATA_VALID` / frame output | TC2, TC4, TC6 (valid output asserted for 8 cycles) |

---

## Waveforms

See [Waveforms](waveforms/) for all captured waveform images with detailed explanations.

---

[< Back to Root](../)
