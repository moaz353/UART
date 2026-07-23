# Simulation

ModelSim-based simulation for the UART_TX design.

---

## Simulator

**Mentor Graphics ModelSim** (Intel FPGA Edition)

---

## Files

| File | Description |
|------|-------------|
| `uart_tx_tb.v` | Testbench with 6 directed test cases |
| `run.tcl` | ModelSim compilation and run script |
| `wave.do` | Waveform configuration (signal grouping and colors) |
| `uart_tx_sim.mpf` | ModelSim project file |
| `Waveforms/` | Captured waveform images |

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
vlog "uart_tx_tb.v"
vlog "../rtl/uart_tx.v"
vlog "../rtl/uart_tx_serializer.v"
vlog "../rtl/uart_tx_parity_bit.v"
vlog "../rtl/uart_tx_mux4x1.v"
vlog "../rtl/uart_tx_controller.v"
vsim -voptargs=+acc uart_tx_tb
run -all
```

### Waveform Viewing

After simulation, load the waveform configuration:

```tcl
do wave.do
```

This configures the wave viewer with signal groups:
- **Top-level signals**: clk, rst_n, p_data, data_valid, par_en, par_typ, tx_out, busy
- **FSM States**: state, next_state
- **Controller signals**: mux_sel, busy
- **Serializer signals**: ser_en, ser_done, ser_data, ser_counter

---

## Testbench Strategy

The testbench (`uart_tx_tb.v`) is a self-checking directed testbench that applies **6 test cases** sequentially. Each test case:

1. Sets up input signals
2. Asserts `DATA_VALID` for one clock cycle
3. Waits 11 clock cycles for frame completion
4. Prints a status message to the console

The clock period is 2 ns (500 MHz in simulation for fast execution).

### Test Cases

| # | Data (`P_DATA`) | `PAR_EN` | `PAR_TYP` | Description |
|---|-----------------|----------|-----------|-------------|
| 1 | `8'b0110_1110` (0x6E) | 1 | 0 | Even parity. 5 ones in data, parity bit = 1. |
| 2 | `8'b0110_0010` (0x62) | 1 | 1 | Odd parity. 3 ones in data, parity bit = 0. |
| 3 | `8'b0100_1010` (0x4A) | 0 | 0 | No parity. 10-bit frame. |
| 4 | `8'b0001_1100` (0x1C) | 0 | 1 | No parity (parity type irrelevant). |
| 5 | `8'b0011_1110` (0x3E) | 0 | 1 | `DATA_VALID=0`. Verifies IDLE is maintained. |
| 6 | `8'b0011_1110` (0x3E) | 1 | 1 | `DATA_VALID=0` with parity enabled. No transmission. |

### Coverage

| Mode | Test Cases |
|------|------------|
| Even parity | TC1 |
| Odd parity | TC2 |
| No parity | TC3, TC4 |
| Idle behavior (DATA_VALID=0) | TC5, TC6 |
| Parity enabled + disabled | TC1-TC2 (enabled), TC3-TC6 (disabled/irrelevant) |

---

## Expected Console Output

```
==============================
TEST CASE 1: EVEN PARITY
==============================
TEST CASE 1 COMPLETED

==============================
TEST CASE 2: ODD PARITY
==============================
TEST CASE 2 COMPLETED

==============================
TEST CASE 3: NO PARITY
==============================
TEST CASE 3 COMPLETED

==============================
TEST CASE 4: NO PARITY
==============================
TEST CASE 4 COMPLETED

==============================
TEST CASE 5: DATA VALID DISABLED
==============================
TEST CASE 5 COMPLETED

==============================
TEST CASE 6: DATA VALID DISABLED WITH PARITY
==============================
TEST CASE 6 COMPLETED
```

---

## Waveforms

See [Waveforms](Waveforms/) for all captured waveform images with detailed explanations.

---

[< Back to Root](../)
