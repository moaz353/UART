###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Step-3 specific variables: checkpoint names and PG mesh / ring
#               parameters.
#
# Flow Stage  : PnR - Step 3 - Power Planning
#
# Dependencies: common/variables.tcl
#
###############################################################################
# Project Physical Design / PnR working directory
set PNR_DIR               "${ROOT_DIR}/pnr"

# ###########################################################################
# 1. Checkpoint naming
# ###########################################################################
set PREV_CHECKPOINT "${DESIGN_NAME}_2_floorplan_ends"
set TEMP_BLOCK      "temp_floorplan_ends"
set NEW_CHECKPOINT  "${DESIGN_NAME}_3_powerplan_ends"

# ###########################################################################
# 2. Standard-cell rail parameters
# ###########################################################################
# The M1 rails run under every standard cell row. Width comes from the PDK.
set RAIL_PATTERN_NAME     "M1_rail"
set RAIL_WIDTH            {0.071 0.071}

# ###########################################################################
# 3. PG mesh parameters (layer / width / pitch / offset)
# ###########################################################################
# Three mesh stages from the reference flow:
#   - middle horizontal   on $pns_mid_layer   (e.g. M5)
#   - top vertical        on $pns_vlayer      (e.g. M6)
#   - top horizontal      on $pns_hlayer      (e.g. M7)
# Widths/pitches are placeholders: tune for the target IR drop budget.

set MESH_MID_LAYER    $pns_mid_layer
set MESH_MID_WIDTH    0.3   
set MESH_MID_PITCH    5.0

set MESH_TOP_V_LAYER  $pns_vlayer
set MESH_TOP_V_WIDTH  0.3
set MESH_TOP_V_PITCH  5.0

set MESH_TOP_H_LAYER  $pns_hlayer
set MESH_TOP_H_WIDTH  0.4
set MESH_TOP_H_PITCH  5.0

set MESH_OFFSET       0.5

# ###########################################################################
# 4. Power ring parameters
# ###########################################################################
set RING_V_LAYER  $pns_vlayer
set RING_H_LAYER  $pns_hlayer
set RING_V_WIDTH  1.0
set RING_H_WIDTH  1.0
set RING_V_SPACE  3.0
set RING_H_SPACE  3.0

# # ###########################################################################
# # 5. Report location for this stage
# # ###########################################################################
set STAGE_REPORT_DIR "${PNR_DIR}/step_3_powerplanning/reports"

# # ###########################################################################
# # 6. PG compile DRC mode
# # ###########################################################################
# # "-ignore_drc" (fast, compiles even with minor DRC violations, cleaned later). 
set PG_COMPILE_MODE "-ignore_drc"

# ###############################################################################
# # End of file
# ###############################################################################
