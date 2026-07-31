# RTL Documentation

Detailed documentation for all Verilog RTL modules in the UART_RX design.

---

## RTL Hierarchy

```
uart_rx (Top Level)
|
+-- uart_rx_controller          FSM + output decode
|   +-- State Memory            3-bit registered state
|   +-- Next-State Logic        Combinational transition logic
|   +-- Output Logic            Enable signals for all sub-modules
|
+-- uart_rx_counters            Edge, bit, and data-valid counters
|   +-- 3-bit edge counter      Counts 8 oversampling edges (0-7)
|   +-- 4-bit bit counter       Bit position within the frame
|   +-- 3-bit data-valid counter  Counts 8 output cycles in DATA_OUT
|
+-- uart_rx_data_sampling       Triple sampling + majority voting
|   +-- 3-bit sample register   Captures rx_in at edge counts 3, 4, 5
|   +-- Majority vote decoder   Resolves samples into sampled_bit
|
+-- uart_rx_deserializer        Frame assembly
|   +-- 8-bit data register     Accumulates sampled data bits (D0-D7)
|   +-- Output logic            Reconstructs P_DATA from frame fields
|
+-- uart_rx_parity_check        Parity calculator + comparator
|   +-- XOR accumulator         Computes parity on received data
|   +-- Error comparator        Compares calculated vs received parity
|
+-- uart_rx_start_check         Start bit verifier
|   +-- Glitch detector         Flags a high majority-sampled start bit
|
+-- uart_rx_stop_check          Stop bit verifier
    +-- Framing detector        Flags a low majority-sampled stop bit
```

---

## Module Descriptions

### uart_rx (Top Level) -- `rtl/uart_rx_top.v`

Top-level module. Instantiates and interconnects all sub-modules. Contains no logic of its own beyond wiring.

| Port         | Direction | Width | Description                                                 |
| ------------ | --------- | ----- | ----------------------------------------------------------- |
| `clk`        | Input     | 1     | System clock                                                |
| `rst_n`      | Input     | 1     | Asynchronous active-low reset                               |
| `rx_in`      | Input     | 1     | Serial receive input                                        |
| `par_en`     | Input     | 1     | Parity enable                                               |
| `par_typ`    | Input     | 1     | Parity type (0=even, 1=odd)                                 |
| `p_data`     | Output    | 11    | Reconstructed frame `{start, data[7:0], parity/stop, stop}` |
| `data_valid` | Output    | 1     | High for 8 clock cycles when `p_data` is valid              |

**Internal wires**: `edge_cnt_top[2:0]`, `bit_cnt_top[3:0]`, `data_valid_cnt_top[2:0]`, `data_sampling_en_top`, `counter_en_top`, `par_chk_en_top`, `stp_chk_en_top`, `str_chk_en_top`, `deser_en_top`, `data_valid_top`, `cnt_zero_top`, `data_valid_par_chk_top`, `data_valid_cnt_en_top`, `calc_par_bit_en_top`, `sampled_bit_top`, `par_err_top`, `calc_par_bit_top`, `str_glitch_top`, `stp_err_top`, `p_data_top[10:0]`

---

### uart_rx_controller -- `rtl/uart_rx_controller.v`

6-state Moore FSM that orchestrates the entire reception sequence. Contains state memory, next-state logic, and output decode logic.

**Inputs**: `clk`, `rst_n`, `rx_in`, `bit_cnt[3:0]`, `edge_cnt[2:0]`, `data_valid_cnt[2:0]`, `str_glitch`, `par_err`, `par_en`, `stp_err`
**Outputs**: `data_sampling_en`, `counter_en`, `cnt_zero`, `par_chk_en`, `stp_chk_en`, `str_chk_en`, `deser_en`, `data_valid`, `data_valid_par_chk`, `data_valid_cnt_en`, `calc_par_bit_en`

| State        | Encoding | Description                                                       |
| ------------ | -------- | ----------------------------------------------------------------- |
| IDLE         | `3'b000` | Waiting for start bit (falling edge on `RX_IN`). Counters zeroed. |
| START_CHECK  | `3'b001` | Oversampling and verifying the start bit. `STR_GLITCH` rejection. |
| DATA_PROCESS | `3'b010` | Sampling the 8 data bits and accumulating the parity.             |
| PAR_CHECK    | `3'b011` | Comparing calculated vs received parity bit (if `PAR_EN=1`).      |
| STP_CHECK    | `3'b100` | Sampling and verifying the stop bit. `STP_ERR` rejection.         |
| DATA_OUT     | `3'b101` | Driving `P_DATA` and `DATA_VALID` for 8 clock cycles.             |

| State        | `SAMPLING_EN` | `COUNTER_EN` | `CNT_ZERO` | `STR_CHK_EN` | `DESER_EN` | `PAR_CHK_EN` | `STP_CHK_EN` | `DATA_VALID` |
| ------------ | ------------- | ------------ | ---------- | ------------ | ---------- | ------------ | ------------ | ------------ |
| IDLE         | 0             | 0            | 1          | 0            | 0          | 0            | 0            | 0            |
| START_CHECK  | 1             | 1            | 0          | 1            | 0          | 0            | 0            | 0            |
| DATA_PROCESS | 1             | 1            | 0          | 0            | 1          | 0            | 0            | 0            |
| PAR_CHECK    | 1             | 1            | 0          | 0            | 0          | 1            | 0            | 0            |
| STP_CHECK    | 1             | 1            | 0          | 0            | 0          | 0            | 1            | 0            |
| DATA_OUT     | 0             | 0            | 1          | 0            | 0          | 0            | 0            | 1            |

**Transition conditions**:

- `IDLE -> START_CHECK`: `rx_in == 0` (falling edge detected)
- `START_CHECK -> IDLE`: `str_glitch && bit_cnt == 2 && edge_cnt == 0` (false start)
- `START_CHECK -> DATA_PROCESS`: `~str_glitch && bit_cnt == 2 && edge_cnt == 0` (valid start)
- `DATA_PROCESS -> PAR_CHECK`: `par_en && bit_cnt == 10`
- `DATA_PROCESS -> STP_CHECK`: `~par_en && bit_cnt == 10`
- `PAR_CHECK -> STP_CHECK`: `~par_err && edge_cnt == 0 && bit_cnt == 11`
- `PAR_CHECK -> IDLE`: `par_err` (parity error, frame discarded)
- `STP_CHECK -> DATA_OUT`: `~stp_err && edge_cnt == 0 && (bit_cnt == 12 || bit_cnt == 11)`
- `STP_CHECK -> IDLE`: `stp_err` (framing error, frame discarded)
- `DATA_OUT -> IDLE`: `data_valid_cnt == 7`

---

### uart_rx_counters -- `rtl/uart_rx_counters.v`

Generates the oversampling edge count, the frame bit count, and the data-valid output count.

**Inputs**: `clk`, `rst_n`, `enable`, `data_valid_cnt_en`, `cnt_zero`
**Outputs**: `bit_cnt[3:0]`, `edge_cnt[2:0]`, `data_valid_cnt[2:0]`

**Behavior**:

- `edge_cnt` increments on every clock while `enable = 1` (8 edges, 0-7)
- `bit_cnt` increments once every 8 edges (when `edge_cnt == 7`)
- `cnt_zero = 1` resets `edge_cnt` and `bit_cnt` to 0
- `data_valid_cnt` increments while `data_valid_cnt_en = 1` (counts 0-7 during `DATA_OUT`)

---

### uart_rx_data_sampling -- `rtl/uart_rx_data_sampling.v`

Samples `rx_in` three times per bit and applies majority voting to produce `sampled_bit`.

**Inputs**: `clk`, `rst_n`, `rx_in`, `data_samp_en`, `edge_cnt[2:0]`, `bit_cnt[3:0]`
**Outputs**: `sampled_bit`

**Behavior**:

- When `data_samp_en = 1`, `rx_in` is captured at edge counts 3, 4, and 5 into `three_samps_data[2:0]`
- `sampled_bit` is updated when `bit_cnt != 0 && edge_cnt == 0` using a 2-of-3 majority vote:

| `three_samps_data`         | `sampled_bit` |
| -------------------------- | ------------- |
| `000`, `001`, `010`, `100` | 0             |
| `011`, `101`, `110`, `111` | 1             |

---

### uart_rx_deserializer -- `rtl/uart_rx_deserializer.v`

Assembles the complete frame: start bit, 8 data bits, optional parity bit, stop bit. 11 bits with `par_en = 1`, 10 bits with `par_en = 0`.

**Inputs**: `clk`, `rst_n`, `deser_en`, `par_en`, `sampled_bit`, `bit_cnt[3:0]`, `edge_cnt[2:0]`, `data_valid`, `calc_par_bit`
**Outputs**: `p_data[10:0]`

**Behavior**:

- Data bits are captured into `p_data_temp[bit_cnt-2]` when `deser_en && edge_cnt == 4 && bit_cnt >= 2 && bit_cnt < 10` (i.e., data bits D0-D7 at `bit_cnt` 2-9)
- Output reconstruction (asserted only while `data_valid = 1`, otherwise `p_data = 0`):
  - With parity: `p_data = {1'b0, p_data_temp, calc_par_bit, 1'b1}`
  - Without parity: `p_data = {1'b0, p_data_temp, 1'b1, 1'b1}`

| Bit           | `PAR_EN = 1`      | `PAR_EN = 0`      |
| ------------- | ----------------- | ----------------- |
| `p_data[10]`  | Start bit (0)     | Start bit (0)     |
| `p_data[9:2]` | Data bits (D7:D0) | Data bits (D7:D0) |
| `p_data[1]`   | Parity bit        | Stop bit (1)      |
| `p_data[0]`   | Stop bit (1)      | Stop bit (1)      |

---

### uart_rx_parity_check -- `rtl/uart_rx_parity_check.v`

Computes even/odd parity on the received data and compares it with the received parity bit.

**Inputs**: `clk`, `rst_n`, `par_typ`, `par_chk_en`, `sampled_bit`, `calc_par_bit_en`, `data_valid_par_chk`, `edge_cnt[2:0]`
**Outputs**: `par_err`, `calc_par_bit`

**Behavior**:

- `calc_par_bit` is reset to 0 (even) or 1 (odd) when `calc_par_bit_en = 0`, seeding the accumulator according to the selected parity type
- While `data_valid_par_chk = 1`, `calc_par_bit` is XORed with each received data bit at `edge_cnt == 4`
- `par_err` is asserted when `par_chk_en && edge_cnt == 7` and `calc_par_bit != sampled_bit` (received parity bit mismatch)

| Mode     | `PAR_TYP` | Accumulator Seed | Result                                                 |
| -------- | --------- | ---------------- | ------------------------------------------------------ |
| **Even** | `0`       | `0`              | XOR of data. `PAR_ERR` if received parity differs.     |
| **Odd**  | `1`       | `1`              | XOR of data + 1. `PAR_ERR` if received parity differs. |

---

### uart_rx_start_check -- `rtl/uart_rx_start_check.v`

Verifies the sampled start bit is logic 0 and rejects line glitches.

**Inputs**: `clk`, `rst_n`, `sampled_bit`, `str_chk_en`
**Outputs**: `str_glitch`

**Behavior**:

- `str_glitch` is asserted while `sampled_bit && str_chk_en`
- A high majority-sampled value during `START_CHECK` means the low pulse was not a genuine start bit; the frame is rejected

---

### uart_rx_stop_check -- `rtl/uart_rx_stop_check.v`

Verifies the sampled stop bit is logic 1 and detects framing errors.

**Inputs**: `clk`, `rst_n`, `sampled_bit`, `stp_chk_en`
**Outputs**: `stp_err`

**Behavior**:

- While `stp_chk_en = 1`, `stp_err` is asserted when `sampled_bit != 1`
- A low majority-sampled stop bit is a framing error; the frame is discarded

---

## FSM State Diagram

See [FSM State Diagram](Snippets/FSM_analysis.png) for the visual state diagram.

See [RTL Elaboration](Snippets/Screenshot%202026-07-30%20225349.png) for the Vivado elaborated schematic.
, [RTL Elaboration with zoom 1](Snippets/Screenshot%202026-07-30%20225403.png) 
and [RTL Elaboration with zoom 2](Snippets/Screenshot%202026-07-30%20225421.png) 

---

## Parameters

### FSM State Encoding

| Parameter      | Value    | Description                       |
| -------------- | -------- | --------------------------------- |
| `IDLE`         | `3'b000` | Idle state, waiting for start bit |
| `START_CHECK`  | `3'b001` | Start bit verification            |
| `DATA_PROCESS` | `3'b010` | Data bit reception                |
| `PAR_CHECK`    | `3'b011` | Parity bit check                  |
| `STP_CHECK`    | `3'b100` | Stop bit check                    |
| `DATA_OUT`     | `3'b101` | Output data state                 |

---

## Files

| File                      | Description                        |
| ------------------------- | ---------------------------------- |
| `uart_rx_top.v`           | Top-level module                   |
| `uart_rx_controller.v`    | FSM controller                     |
| `uart_rx_counters.v`      | Edge, bit, and data-valid counters |
| `uart_rx_data_sampling.v` | Triple sampling + majority voting  |
| `uart_rx_deserializer.v`  | Frame assembly                     |
| `uart_rx_parity_check.v`  | Parity calculator + comparator     |
| `uart_rx_start_check.v`   | Start bit verifier                 |
| `uart_rx_stop_check.v`    | Stop bit verifier                  |
| `Snippets/`               | FSM and RTL elaboration images     |

---

[< Back to Root](../)
