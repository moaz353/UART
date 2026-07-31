# Synthesis Reports

Post-synthesis analysis of the UART_RX design.

**Tool**: Vivado v.2018.2
**Device**: xc7a35tcpg236-1
**Design State**: Synthesized

---

## Utilization

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| Slice LUTs | 56 | 20,800 | 0.27% |
| Slice Registers (FFs) | 31 | 41,600 | 0.07% |
| Block RAM | 0 | 50 | 0.00% |
| DSP | 0 | 90 | 0.00% |
| Bonded IOB | 17 | 106 | 16.04% |
| BUFGCTRL | 1 | 32 | 3.13% |

### Register Breakdown

| Type | Count |
|------|-------|
| Clock Enable + Async Reset | 25 |
| Clock Enable + Sync Set | 1 |
| Clock Enable + Sync Reset | 5 |
| **Total** | **31** |

### Primitives

| Primitive | Used | Category |
|-----------|------|----------|
| FDCE | 25 | Flip-Flop |
| LUT6 | 20 | Logic |
| LUT2 | 17 | Logic |
| LUT4 | 15 | Logic |
| OBUF | 12 | I/O |
| LUT3 | 9 | Logic |
| LUT5 | 6 | Logic |
| IBUF | 5 | I/O |
| FDRE | 5 | Flip-Flop |
| LUT1 | 2 | Logic |
| FDSE | 1 | Flip-Flop |
| BUFG | 1 | Clock |

---

## Timing Summary

| Metric | Value |
|--------|-------|
| WNS (Worst Negative Slack) | 6.978 ns |
| TNS (Total Negative Slack) | 0.000 ns |
| WHS (Worst Hold Slack) | 0.142 ns |
| THS (Total Hold Slack) | 0.000 ns |
| WPWS (Worst Pulse Width Slack) | 4.500 ns |
| Timing Constraints | All MET |
| Failing Endpoints | 0 |

Clock: `sys_clk_pin` at 100 MHz (10 ns period)

---

## Power Summary

| Metric | Value |
|--------|-------|
| Total On-Chip Power | 0.074 W |
| Dynamic Power | 0.002 W |
| Device Static Power | 0.072 W |
| Junction Temperature | 25.4 C |
| Max Ambient | 84.6 C |

### By Hierarchy

| Module | Power |
|--------|-------|
| `uart_rx` | 0.002 W |
| `uart_rx_controller_blk` | < 0.001 W |
| `uart_rx_counters_blk` | < 0.001 W |
| `uart_rx_data_sampling_blk` | < 0.001 W |
| `uart_rx_deserializer_blk` | < 0.001 W |
| `uart_rx_parity_check_blk` | < 0.001 W |
| `uart_rx_start_check_blk` | < 0.001 W |
| `uart_rx_stop_check_blk` | < 0.001 W |

---

## Images

### Schematic

![Schematic 1](schematic/Screenshot%202026-07-30%20230103.png)

![Schematic 2](schematic/Screenshot%202026-07-30%20230113.png)

![Schematic 3](schematic/Screenshot%202026-07-30%20230135.png)

![Schematic 4](schematic/Screenshot%202026-07-30%20230142.png)

Synthesis schematic views of the elaborated netlist.

### Timing Summary

![Timing Summary](Timing_summary.png)

### Power Summary

![Power Summary](power_summary.png)

### Utilization Summary

![Utilization Summary](utilization_summary.png)

---

## Report Files

| File | Description |
|------|-------------|
| `utilization_report.rpt` | Full utilization report |
| `timing_report.rpt` | Full timing report with path details |
| `power.rpt` | Full power report |
| `schematic/` | Synthesis schematic screenshots |
| `Timing_summary.png` | Timing summary screenshot |
| `power_summary.png` | Power summary screenshot |
| `utilization_summary.png` | Utilization summary screenshot |

---

[< Back to FPGA Flow](../)
