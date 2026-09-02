# Formality

Formality performs **formal (equivalence) verification**: it proves that the gate-level netlist produced by synthesis implements the original (pre-synthesis) RTL, for all possible input sequences. Here it verifies the upright equations between the **RTL (`uart.v` and sub-modules)** as *reference* and the synthesized **gate-level netlist (`uart_netlist.v`)** as *implementation*, using the synthesis SVF for optimal guidance.

A note on the environment: the Formality run was executed on a separate machine from the rest of the flow. The required files (`req_files/`) were transferred to that machine and machine-specific paths in the scripts were updated to match its directory structure — the verification flow itself was unchanged.

## Flow

1. `run_fm.tcl` — launches `fm_shell` on the master script (transcript to `logs/fm.log`).
2. `scripts/master.tcl` — driver; sources the stage scripts in order.
3. Reference setup — read the RTL (`uart.v`, `rtl_rx/*`, `rtl_tx/*`) and `elaborate`, then read the SVF (`uart_fm.svf`).
4. Implementation setup — read the synthesized netlist (`uart_netlist.v`).
5. `verify` — full verification between the two designs.
6. `scripts/reports.tcl` — writes the compare-point reports.

## Inputs / Outputs

| Item | Location |
|------|----------|
| Reference (RTL) | `../rtl/` (paths listed explicitly in `scripts/variables.tcl`) |
| Implementation (netlist) | `common/req_files/uart_netlist.v` |
| SVF guidance | `common/req_files/uart_fm.svf` |
| Reports | `reports/` (passing / failing / aborted / unverified points) |

## Results

- **Compare points — 54 passing**, 0 failing, 0 aborted, 0 unverified (`reports/passing_points.rpt`, etc.).
- netlist ≡ RTL: **formally equivalent**.

## Visuals

Formality is a command-line-only tool; the verification results are recorded in the `reports/` files linked above.