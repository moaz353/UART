###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Step-4 specific variables.
#
# Flow Stage  : PnR - Step 4 - Placement
#
# Dependencies: common/variables.tcl
#
###############################################################################

set PNR_DIR               "${ROOT_DIR}/pnr"

# ###########################################################################
# 1. Checkpoint naming
# ###########################################################################
set PREV_CHECKPOINT "${DESIGN_NAME}_3_powerplan_ends"
set TEMP_BLOCK      "temp_powerplan_ends"
set NEW_CHECKPOINT  "${DESIGN_NAME}_4_place_ends"

# ###########################################################################
# 2. Optimization naming
# ###########################################################################
# Instance-name prefix added by the optimizer, used to tag cells the tool
# creates during this stage (helps tracing ECO/legalization fixes).
set USER_INSTANCE_PREFIX "place"

# ###########################################################################
# 3. Report location for this stage
# ###########################################################################
set STAGE_REPORT_DIR "${PNR_DIR}/step_4_placement/reports"

###############################################################################
# End of file
###############################################################################
