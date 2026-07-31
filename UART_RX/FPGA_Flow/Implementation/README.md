# Implementation Reports

Post-implementation (place and route) analysis of the UART_RX design.

**Tool**: Vivado v.2018.2
**Device**: xc7a35tcpg236-1
**Design State**: Routed

---

## Utilization (Post-Implementation)

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| Slice LUTs | 56 | 20,800 | 0.27% |
| Slice Registers (FFs) | 31 | 41,600 | 0.07% |
| Block RAM | 0 | 50 | 0.00% |
| DSP | 0 | 90 | 0.00% |
| Bonded IOB | 17 | 106 | 16.04% |
| BUFGCTRL | 1 | 32 | 3.13% |

### Slices Used

| Type | Count |
|------|-------|
| SLICEL | 13 |
| SLICEM | 5 |
| **Total Slices** | **18** |

### LUT Flip-Flop Pairs

| Metric | Value |
|--------|-------|
| LUT Flip Flop Pairs | 26 |
| Fully used LUT-FF pairs | 2 |
| LUT-FF pairs with one unused LUT output | 23 |
| LUT-FF pairs with one unused Flip Flop | 24 |
| Unique Control Sets | 6 |

---

## Timing Summary (Post-Implementation)

| Metric | Value |
|--------|-------|
| WNS (Worst Negative Slack) | **6.493 ns** |
| TNS (Total Negative Slack) | 0.000 ns |
| WHS (Worst Hold Slack) | 0.143 ns |
| THS (Total Hold Slack) | 0.000 ns |
| WPWS (Worst Pulse Width Slack) | 4.500 ns |
| Timing Constraints | **All MET** |
| Failing Endpoints | 0 |

### Critical Path (Worst Setup)

- **Source**: `uart_rx_controller_blk/FSM_onehot_state_reg[2]/C`
- **Destination**: `uart_rx_data_sampling_blk/three_samps_data_reg[0]/CE`
- **Data Path Delay**: 3.038 ns (logic: 0.730 ns, route: 2.308 ns)
- **Logic Levels**: 2 (LUT4)
- **Slack**: 6.493 ns

The design closes timing comfortably at 100 MHz with 6.5 ns of setup margin.

---

## DRC Results

**0 violations found.** Clean design rule check.

---

## Power Summary (Post-Implementation)

| Metric | Value |
|--------|-------|
| Total On-Chip Power | 0.074 W |
| Dynamic Power | 0.002 W |
| Device Static Power | 0.072 W |
| Junction Temperature | 25.4 C |
| Max Ambient | 84.6 C |

---

## Device View

![Device View](Device/Screenshot%202026-07-30%20233002.png)

![Device View 2](Device/Screenshot%202026-07-30%20233017.png)

![Device View 3](Device/Screenshot%202026-07-30%20233032.png)

Post-placement and routing device views showing slice placement on the xc7a35t die.

---

## Images

### Timing Summary

![Timing Summary](timing_summary.png)

### Power Summary

![Power Summary](power_summary.png)

### Utilization Summary

![Utilization Summary](utilization_summary.png)

---

## Report Files

| File | Description |
|------|-------------|
| `utilization_report.rpt` | Full post-implementation utilization report |
| `timing_report.rpt` | Full timing report with detailed path analysis |
| `power_report.rpt` | Full power report |
| `DRC_report.rpt` | Design rule check report |
| `Device/` | Device view screenshots |
| `timing_summary.png` | Timing summary screenshot |
| `power_summary.png` | Power summary screenshot |
| `utilization_summary.png` | Utilization summary screenshot |

---

[< Back to FPGA Flow](../)
