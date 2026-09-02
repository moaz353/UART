###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Step-7 specific variables: checkpoint names and physical
#               finishing parameters (fillers, metal fill).
#
# Flow Stage  : PnR - Step 7 - Finishing
#
# Dependencies: common/variables.tcl
#
###############################################################################

set PNR_DIR               "${ROOT_DIR}/pnr"

# ###########################################################################
# 1. Checkpoint naming
# ###########################################################################
set PREV_CHECKPOINT "${DESIGN_NAME}_6_complete"
set TEMP_BLOCK      "temp_route_ends"
set NEW_CHECKPOINT  "${DESIGN_NAME}_7_finished"

# ###########################################################################
# 2. Report location for this stage
# ###########################################################################
set STAGE_REPORT_DIR           "${PNR_DIR}/step_7_finishing/reports"
set STAGE_OUTPUT_DIR           "${PNR_DIR}/step_7_finishing/outputs"

###############################################################################
# End of file
###############################################################################
