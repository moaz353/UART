# RTL

This directory holds the RTL source files used by the ASIC flow (synthesis, synthesis-based STA, and formal verification). It contains the RTL for both UART RX and UART TX because the ASIC flow is performed on the complete UART design. The combined RTL is synthesized into a gate-level netlist by Design Compiler.

## Important: Source of the RTL

The RTL for both RX and TX was gathered into `ASIC_FLOW/rtl/` from their respective locations elsewhere in the project, specifically to provide a self-contained RTL source directory for the ASIC flow. The individual RX and TX blocks each retain their own separate simulation and FPGA flows — this directory does not change that project structure.

Treat `ASIC_FLOW/rtl/` as the ASIC flow's dedicated RTL source, **not** as the project-wide source of truth for RX or TX.

## Directory Structure

```
rtl/
├── rtl_rx/   # UART receiver blocks
│   ├── uart_rx.v
│   ├── uart_rx_controller.v
│   ├── uart_rx_counters.v
│   ├── uart_rx_data_sampling.v
│   ├── uart_rx_deserializer.v
│   ├── uart_rx_parity_check.v
│   ├── uart_rx_start_check.v
│   └── uart_rx_stop_check.v
├── rtl_tx/   # UART transmitter blocks
│   ├── uart_tx.v
│   ├── uart_tx_controller.v
│   ├── uart_tx_mux4x1.v
│   ├── uart_tx_parity_bit.v
│   └── uart_tx_serializer.v
└── uart.v    # Top-level UART module
```

## Organization

- `rtl_rx/` — the **receiver** datapath and control. It samples the serial input, checks the start/stop bits and parity, and deserializes the incoming frame (`uart_rx.v` ties the sub-blocks together).

- `rtl_tx/` — the **transmitter** datapath and control. It serializes a parallel word, builds the parity bit, muxes/controls the frame, and drives the serial output (`uart_tx.v` ties the sub-blocks together).

- `uart.v` — the **top-level** module instantiating the RX and TX datapaths. This is the module name (`uart`) referenced throughout the flow as the design name.

## Design at a Glance

Single-clock UART peripheral with programmable parity and a `/8` baud-rate divider (`tx_clk = baud_cnt[2]`, receiver oversamples 8×).

| Port | Direction | Description |
|------|-----------|-------------|
| `clk` / `rst_n` | in | System clock / active-low async reset |
| `p_data[7:0]`, `data_valid` | in | Parallel TX data + write strobe |
| `par_en`, `par_typ` | in | Parity enable; even (0) / odd (1) |
| `tx_out`, `busy` | out | Serial TX output / TX busy flag |
| `rx_in` | in | Serial RX input |
| `rx_p_data[10:0]`, `rx_data_valid` | out | Parallel RX frame (start+data+parity+stop) + valid |

TX serializes `p_data` (start bit + 8 data + parity + stop) via a 4:1 mux and parity logic; RX samples the line, checks start/stop/parity, and deserializes the frame. Both datapaths share the top-level `clk` and a free-running baud counter.

## Role in the ASIC Flow

These RTL files are the starting point of the ASIC implementation chain:

1. Design Compiler (in `syn/`) reads them (as listed in `syn/scripts/variables.tcl` — RX/TX leaf modules first, top module `uart.v` last).
2. Synthesis maps the RTL to the gate-level netlist that feeds PnR and formal verification.
