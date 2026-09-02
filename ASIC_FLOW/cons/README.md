# Constraints

This directory contains the **design constraints framework** — the timing and physical intent that the synthesis and PnR flows are told to meet. The constraints, written in Tcl/SDC, define how the design's timing requirements are expressed to the tools, so a reader visiting this folder should understand "where the timing intent comes from."

## Why Constraints are Needed

Logic synthesis (DC) and physical design (ICC2) do not know what the design is supposed to achieve on their own. The constraints in this folder tell them the clock definitions, the timing allowed on inputs and outputs, the operating conditions to analyze, and the design rules to honor. Every optimization decision downstream — from compiles in synthesis to placement, CTS, and routing in PnR — is driven by these requirements.

## Structure

The framework is organized into two layers plus a top-level driver:

- `master.tcl` — The single entry point. It sources every constraint module in a dependency-safe order: first the framework variables, then the mandatory `setup/` files, then any enabled `optional/` modules. The synthesis stage sources this file directly (`syn/scripts/constraints_setup.tcl`).

- `variables.tcl` — Constraint-framework-only variables: clock parameters, design-rule limits, driving-cell/load values, and the `ENABLE_*` flags that turn each optional module on or off.

- `setup/` — The **mandatory** constraints applied to every design:
  - `clocks.tcl` — Master clock creation plus its latency, uncertainty, and transition.
  - `io_constraints.tcl` — Input/output delays relative to the clock.
  - `driving_cells.tcl` — A driving cell model applied to all input ports.
  - `loads.tcl` — A capacitive load applied to all output ports.
  - `operating_conditions.tcl` — The min (fast/FF, for hold) and max (slow/SS, for setup) analysis corners.
  - `design_rules.tcl` — Max transition, max fanout, and max capacitance limits.

- `optional/` — **Optional / advanced** modules, each guarded by an `ENABLE_*` flag in `variables.tcl`. `master.tcl` defines twelve such modules (generated clocks, clock groups, case analysis, false paths, multicycle paths, min/max delays, disabled timing, don't-touch, wireload model, area constraints, power constraints, advanced). Of these, **`wireload_model.tcl`, `area_constraints.tcl`, and `advanced_constraints.tcl` ship with this project** and are enabled by default; the remaining modules are left disabled (their files are not present).

## Timing Intent (this project)

| Parameter | Value |
|-----------|-------|
| Master clock | `sys_clk` on port `clk`, period **10 ns** |
| Clock latency / transition | 0 ns / 0.05 ns rise & fall |
| Setup & hold uncertainty | 0.1 ns each |
| Input / output delay | 20 % of period (`io_delay_factor 0.2` → 2.0 ns) |
| Input driving cell | `IBUFFX2_Y` (from selected std-corner library) |
| Output load | 0.02 |
| Design rules | max transition 0.5, max fanout 16, max capacitance 0.5 |
| Operating conditions | min = FF corner (hold), max = SS corner (setup) |

## How the Constraints Are Consumed

1. **Synthesis (DC)** reads the constraints by sourcing `master.tcl`, then uses the exported post-synthesis SDC as one of its outputs.
2. **PnR (ICC2)** feeds on that post-synthesis SDC (`syn/output/uart_output.sdc`) through the MCMM setup in `common/mcmm.tcl`, which reads it into each corner scenario before placement, CTS, routing, and finishing.
3. The same SDC drives signoff timing analysis after physical design completes.

## Key Files

- `master.tcl` — framework entry point (synthesis sources this file)
- `variables.tcl` — framework variables and `ENABLE_*` flags
- `setup/clocks.tcl`, `setup/io_constraints.tcl`, `setup/operating_conditions.tcl` — the core timing intent
- `optional/wireload_model.tcl`, `optional/area_constraints.tcl`, `optional/advanced_constraints.tcl` — enabled optional modules
