###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Step-2 specific variables.
#
# Flow Stage  : PnR - Step 2 - Floorplanning
#
# Dependencies: common/variables.tcl
#
###############################################################################

set PNR_DIR               "${ROOT_DIR}/pnr"

# ###########################################################################
# 1. Checkpoint naming
# ###########################################################################
set PREV_CHECKPOINT "${DESIGN_NAME}_1_data_setup"
set TEMP_BLOCK      "temp_data_setup"
set NEW_CHECKPOINT  "${DESIGN_NAME}_2_floorplan_ends"

# ###########################################################################
# 2. Floorplan parameters
# ###########################################################################

# Core utilization and core-to-die boundary offsets used for floorplan sizing.
set CORE_UTILIZATION      0.2
set CORE_OFFSET           {13.5 13.5 13.5 13.5}

# Wire track pattern for the M1 standard-cell rails (from the PDK).
set WIRE_TRACK_LAYER      "M1"
set WIRE_TRACK_COORD      0.037
set WIRE_TRACK_SPACE      0.074

# ###########################################################################
# 3. Report location for this stage
# ###########################################################################
set STAGE_REPORT_DIR "${PNR_DIR}/step_2_floorplanning/reports"

###############################################################################
# End of file
###############################################################################


