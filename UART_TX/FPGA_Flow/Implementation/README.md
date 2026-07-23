# Implementation Reports

Post-implementation (place and route) analysis of the UART_TX design.

**Tool**: Vivado v.2018.2
**Device**: xc7a35tcpg236-1
**Design State**: Routed

---

## Utilization (Post-Implementation)

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| Slice LUTs | 19 | 20,800 | 0.09% |
| Slice Registers (FFs) | 11 | 41,600 | 0.03% |
| Block RAM | 0 | 50 | 0.00% |
| DSP | 0 | 90 | 0.00% |
| Bonded IOB | 15 | 106 | 14.15% |
| BUFGCTRL | 1 | 32 | 3.13% |

### Slices Used

| Type | Count |
|------|-------|
| SLICEL | 6 |
| SLICEM | 1 |
| **Total Slices** | **7** |

---

## Timing Summary (Post-Implementation)

| Metric | Value |
|--------|-------|
| WNS (Worst Negative Slack) | **37.639 ns** |
| TNS (Total Negative Slack) | 0.000 ns |
| WHS (Worst Hold Slack) | 0.163 ns |
| THS (Total Hold Slack) | 0.000 ns |
| WPWS (Worst Pulse Width Slack) | 4.500 ns |
| Timing Constraints | **All MET** |
| Failing Endpoints | 0 |

### Critical Path (Worst Setup)

- **Source**: `ser_counter_reg[1]/C`
- **Destination**: `ser_data_reg/D`
- **Data Path Delay**: 2.333 ns (logic: 0.704 ns, route: 1.629 ns)
- **Logic Levels**: 2 (LUT6)
- **Slack**: 37.639 ns

The massive positive slack (37.6 ns on a 40 ns clock) confirms the design has no timing issues at 25 MHz.

---

## DRC Results

**0 violations found.** Clean design rule check.

---

## Power Summary (Post-Implementation)

| Metric | Value |
|--------|-------|
| Total On-Chip Power | 0.072 W |
| Dynamic Power | < 0.001 W |
| Device Static Power | 0.072 W |
| Junction Temperature | 25.4 C |
| Max Ambient | 84.6 C |

---

## Device View

![Device View](Device.png)

Post-placement and routing device view showing slice placement on the xc7a35t die.

---

## Images

### Post-Implementation Schematic

![Schematic](Schematic.png)

### Device View

![Device View](Device.png)

### Timing Summary

![Timing Summary](Timing_summary.png)

### Power Summary

![Power Summary](Power_summary.png)

---

## Report Files

| File | Description |
|------|-------------|
| `utilization.rpt` | Full post-implementation utilization report |
| `timing_report.rpt` | Full timing report with detailed path analysis |
| `power.rpt` | Full power report |
| `DRC.rpt` | Design rule check report |
| `Schematic.png` | Post-implementation schematic screenshot |
| `Device.png` | Device view screenshot |
| `Timing_summary.png` | Timing summary screenshot |
| `Power_summary.png` | Power summary screenshot |

---

[< Back to FPGA Flow](../)
