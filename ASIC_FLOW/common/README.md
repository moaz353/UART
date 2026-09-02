# Common

This directory holds the **shared infrastructure** used by every stage of the ASIC flow (synthesis, PnR, and formal verification). All the repetitive, cross-cutting logic that each tool needs is centralized here, so a single change stays consistent across the whole project.

## Role in the ASIC Flow

Each stage's `master.tcl` starts by sourcing this folder's files before doing any stage-specific work. That means the design identity, the technology/library selection, and the tool-agnostic environment are all guaranteed to be identical when DC, ICC2, or Formality run. Keeping this logic in one place prevents the synthesis and PnR teams from drifting apart on library or corner choices.

## Contents

The files group into a few conceptual layers:

- **Project & design identity** — `variables.tcl` defines the central, project-specific values: the project root, design name (`uart`), library/PDK locations, RTL and constraints paths, and the SVF file used for formal verification.

- **Library / corner selection** — `library_selection.tcl` is the project-level selection layer. It picks the active standard-cell, SRAM, I/O and PLL corners (e.g. the TT synthesis corner plus the FF/SS min/max analysis corners), and exports `SELECTED_*` variables. It also selects the RC (TLU+) determination, technology files, NDM reference libraries, LEF/GDS files and special-cell lists (fillers, tap/antenna cells). This is the single point where a corner change propagates through the entire flow.

- **Tool environment setup** — `design_setup.tcl` turns those selections into tool-agnostic settings: search path, `link_library`, `target_library`, and the NDM design-library path created by PnR Step 1.

- **MCMM configuration** — `mcmm.tcl` builds the Multi-Corner Multi-Mode setup for ICC2: it creates the slow/fast corners, the functional mode and the two `func_slow` / `func_fast` scenarios, attaches the TLU+ parasitic models, and reads the post-synthesis SDC into each scenario. Synthesis/PnR stages that are timing-aware source this file.

- **Common procedures** — `common_procedures.tcl` implements the recurring patterns of the flow as reusable routines: opening/saving/checkpointing blocks (`open_lb_from_checkpoint`, `save_lb_to_checkpoint`), power/ground net setup (`setup_pg_nets`), QoR snapshots and standard reports (`create_qor_snapshot_and_report`, `report_timing_max_min`), path-group setup, and console banners.

- **Helper utilities** — `helper_functions.tcl` provides small, flow-independent helpers such as `ensure_directory`, `check_file_exists`, `require_file`, and `prefix_list`.

## Why Centralize

Because synthesis (DC), physical design (ICC2), and formal verification all consume the same corner, library, and environment selections, a change here is applied everywhere at once. This keeps the constraints, the target libraries, and the PnR database consistent, and avoids the common failure mode where different tools are pointed at different corners or library versions.
