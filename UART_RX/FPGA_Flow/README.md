# FPGA Flow

Complete Vivado FPGA implementation flow for the UART_RX design targeting the Digilent Basys3 board.

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

`uart_rx_top_Basys_3.xdc` -- Pin assignments and clock constraint for Basys3.

### Clock

```tcl
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
```

100 MHz onboard oscillator mapped to `clk` input.

### Pin Mapping

| Signal | Pin | Board Element |
|--------|-----|---------------|
| `clk` | W5 | Oscillator (100 MHz) |
| `rst_n` | U18 | CPU Reset Button |
| `rx_in` | V17 | Switch SW0 |
| `par_en` | V16 | Switch SW1 |
| `par_typ` | W16 | Switch SW2 |
| `data_valid` | U16 | LED LD0 |
| `p_data[0]` | U3 | LED LD11 |
| `p_data[1]` | E19 | LED LD1 |
| `p_data[2]` | U19 | LED LD2 |
| `p_data[3]` | V19 | LED LD3 |
| `p_data[4]` | W18 | LED LD4 |
| `p_data[5]` | U15 | LED LD5 |
| `p_data[6]` | U14 | LED LD6 |
| `p_data[7]` | V14 | LED LD7 |
| `p_data[8]` | V13 | LED LD8 |
| `p_data[9]` | V3 | LED LD9 |
| `p_data[10]` | W3 | LED LD10 |

---

## Vivado Project

Pre-built project file: `UART_RX/UART_RX.xpr`

Contains:
- All RTL sources from `../rtl/`
- Constraint file `uart_rx_top_Basys_3.xdc`
- Board part `digilentinc.com:basys3:part0:1.2`
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
| `uart_rx_top_Basys_3.xdc` | Pin and clock constraints |
| `UART_RX/UART_RX.xpr` | Vivado project file |
| `Synthesis/` | Synthesis reports and images |
| `Implementation/` | Implementation reports and images |

---

[< Back to Root](../)
