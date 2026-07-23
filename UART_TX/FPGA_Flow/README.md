# FPGA Flow

Complete Vivado FPGA implementation flow for the UART_TX design targeting the Digilent Basys3 board.

---

## Target Device

| Parameter | Value |
|-----------|-------|
| FPGA Part | `xc7a35tcpg236-1` |
| Board | Digilent Basys3 |
| Package | CPG236 |
| Speed Grade | -1 |
| Tool | Vivado v.2018.2 |

---

## Constraint File

`constraints_basys3.xdc` -- Pin assignments and clock constraint for Basys3.

### Clock

```tcl
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 40.00 -waveform {0 5} [get_ports clk]
```

25 MHz onboard oscillator mapped to `clk` input.

### Pin Mapping

| Signal | Pin | Board Element |
|--------|-----|---------------|
| `clk` | W5 | Oscillator (25 MHz) |
| `rst_n` | U18 | CPU Reset Button |
| `p_data[0]` | V17 | Switch SW0 |
| `p_data[1]` | V16 | Switch SW1 |
| `p_data[2]` | W16 | Switch SW2 |
| `p_data[3]` | W17 | Switch SW3 |
| `p_data[4]` | W15 | Switch SW4 |
| `p_data[5]` | V15 | Switch SW5 |
| `p_data[6]` | W14 | Switch SW6 |
| `p_data[7]` | W13 | Switch SW7 |
| `data_valid` | T3 | Switch SW8 |
| `par_en` | T2 | Switch SW9 |
| `par_typ` | R3 | Switch SW10 |
| `tx_out` | U16 | LED LD0 |
| `busy` | E19 | LED LD8 |

---

## Vivado Project

Pre-built project file: `uart_tx/uart_tx.xpr`

Contains:
- All RTL sources from `../rtl/`
- Constraint file `constraints_basys3.xdc`
- Synthesis run (`synth_1`)
- Implementation run (`impl_1`)

---


## Reports

| Report | Location |
|--------|----------|
| Synthesis Reports | [Synthesis/](Synthesis/) |
| Implementation Reports | [Implementation/](Implementation/) |

---

## Files

| File | Description |
|------|-------------|
| `constraints_basys3.xdc` | Pin and clock constraints |
| `uart_tx/uart_tx.xpr` | Vivado project file |
| `Synthesis/` | Synthesis reports and images |
| `Implementation/` | Implementation reports and images |

---

[< Back to Root](../)
