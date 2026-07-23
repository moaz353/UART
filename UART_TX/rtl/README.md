# RTL Documentation

Detailed documentation for all Verilog RTL modules in the UART_TX design.

---

## RTL Hierarchy

```
uart_tx (Top Level)
|
+-- uart_tx_controller          FSM + output decode
|   +-- State Memory            3-bit registered state
|   +-- Next-State Logic        Combinational transition logic
|   +-- Output Logic            MUX select, busy, serializer enable
|
+-- uart_tx_serializer          Parallel-to-serial converter
|   +-- 3-bit counter           Tracks bit position (0-7)
|   +-- Data register           Shifts out P_DATA[counter]
|   +-- Done detector           Asserts ser_done when counter == 7
|
+-- uart_tx_parity_bit          Parity calculator
|   +-- XOR / XNOR logic        Computes even or odd parity on P_DATA
|
+-- uart_tx_mux4x1              Output multiplexer
    +-- 4:1 MUX                 Selects Start / Stop / Data / Parity for TX_OUT
```

---

## Module Descriptions

### uart_tx (Top Level) -- `rtl/uart_tx.v`

Top-level module. Instantiates and interconnects all sub-modules. Contains no logic of its own beyond wiring.

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `clk` | Input | 1 | System clock |
| `rst_n` | Input | 1 | Asynchronous active-low reset |
| `p_data` | Input | 8 | Parallel data byte |
| `data_valid` | Input | 1 | Transfer initiation pulse |
| `par_en` | Input | 1 | Parity enable |
| `par_typ` | Input | 1 | Parity type (0=even, 1=odd) |
| `tx_out` | Output | 1 | Serial output |
| `busy` | Output | 1 | Busy status |

**Internal wires**: `ser_done`, `mux_sel[1:0]`, `ser_en`, `par_bit`, `ser_data`

---

### uart_tx_controller -- `rtl/uart_tx_controller.v`

5-state Moore FSM that orchestrates the entire transmission sequence. Contains state memory, next-state logic, and output decode logic.

**Inputs**: `clk`, `rst_n`, `data_valid`, `par_en`, `ser_done`
**Outputs**: `mux_sel[1:0]`, `busy`, `ser_en`

| State | Encoding | `MUX_SEL` | `BUSY` | `SER_EN` | MUX Output |
|-------|----------|-----------|--------|----------|------------|
| IDLE | `3'b000` | `2'b01` | 0 | 0 | Stop (1) |
| START | `3'b001` | `2'b00` | 1 | 1 | Start (0) |
| PARALLEL_DATA | `3'b010` | `2'b10` | 1 | 1 | Serial data |
| PARITY_BIT | `3'b011` | `2'b11` | 1 | 0 | Parity |
| STOP | `3'b100` | `2'b01` | 1 | 0 | Stop (1) |

---

### uart_tx_serializer -- `rtl/uart_tx_serializer.v`

8-bit parallel-to-serial converter. Uses a 3-bit counter to index into `P_DATA` and output one bit per clock cycle when enabled.

**Inputs**: `clk`, `rst_n`, `p_data[7:0]`, `ser_en`
**Outputs**: `ser_data`, `ser_done`

**Behavior**:
- When `ser_en = 1`: outputs `p_data[ser_counter]` and increments counter
- When `ser_en = 0`: counter resets to 0, `ser_data` set to 1 (idle)
- `ser_done` asserted when `ser_counter == 7`

---

### uart_tx_parity_bit -- `rtl/uart_tx_parity_bit.v`

Registered parity calculator. Computes even or odd parity using XOR/XNOR reduction.

**Inputs**: `clk`, `rst_n`, `p_data[7:0]`, `par_typ`
**Outputs**: `par_bit`

**Logic**:
- Even parity (`par_typ = 0`): `par_bit = ^p_data` (XOR reduction)
- Odd parity (`par_typ = 1`): `par_bit = ~^p_data` (XNOR reduction)

---

### uart_tx_mux4x1 -- `rtl/uart_tx_mux4x1.v`

Combinational 4-to-1 multiplexer. Selects the output bit driven on `TX_OUT`.

**Inputs**: `in0`, `in1`, `in2`, `in3`, `mux_sel[1:0]`
**Outputs**: `mux_out`

| `mux_sel` | Output | Connected To |
|-----------|--------|--------------|
| `2'b00` | `in0` | Start bit (0) |
| `2'b01` | `in1` | Stop bit (1) |
| `2'b10` | `in2` | Serial data |
| `2'b11` | `in3` | Parity bit |

---

## Signal Flow Diagram

```
                    +----------------------+
   P_DATA [7:0] ----|                      |---- ser_data
   DATA_VALID  -----|  uart_tx_serializer  |---- ser_done
   SER_EN      -----|                      |
                    +----------------------+
                              |
   CLK -----------------------+-----------------------------------------+
   RST_n ---------------------+-----------------------------------------+
                              |
                    +----------------------+
   DATA_VALID ------|                      |
   PAR_EN     ------|  uart_tx_controller  |
   SER_DONE   ------|                      |
                    +----------------------+
                     |            |
                     | MUX_SEL    | SER_EN
                     |            |
                    +----------------------+
   P_DATA [7:0] ----|                      |
   PAR_TYP     -----|  uart_tx_parity_bit  |
                    +----------------------+
                    |            |
                    | PAR_BIT    |
                    |            |
                    +----------------------------------------+
    in0(0) ---------|                                        |
    in1(1) ---------|        uart_tx_mux4x1                  |
    ser_data -------|                                        |---- TX_OUT
    par_bit  -------|                                        |
    mux_sel [1:0] --|                                        |
                    +----------------------------------------+
```

---

## FSM State Diagram

See [FSM State Diagram](Snippets/FSM_analysis.png) for the visual state diagram.

See [RTL Elaboration](Snippets/RTL_elaboration.png) for the Vivado elaborated schematic.

---

## Parameters

### FSM State Encoding

| Parameter | Value | Description |
|-----------|-------|-------------|
| `IDEAL` | `3'b000` | Idle state |
| `START` | `3'b001` | Start bit transmission |
| `PARALLEL_DATA` | `3'b010` | Data bit transmission |
| `PARITY_BIT` | `3'b011` | Parity bit transmission |
| `STOP` | `3'b100` | Stop bit transmission |

---

## Files

| File | Description |
|------|-------------|
| `uart_tx.v` | Top-level module |
| `uart_tx_controller.v` | FSM controller |
| `uart_tx_serializer.v` | Parallel-to-serial converter |
| `uart_tx_parity_bit.v` | Parity calculator |
| `uart_tx_mux4x1.v` | 4:1 output multiplexer |
| `Snippets/` | FSM and RTL elaboration images |

---

[< Back to Root](../)
