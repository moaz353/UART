###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Step-1 specific variables (checkpoint and temp block names).
#
# Flow Stage  : PnR - Step 1 - Data Setup
#
#
# Dependencies: common/variables.tcl
#
###############################################################################
# Project Physical Design / PnR working directory
set PNR_DIR               "${ROOT_DIR}/pnr"

# ###########################################################################
# 1. Checkpoint naming
# ###########################################################################
# Step 1 CREATES the library, so there is no previous checkpoint to copy.
# The first saved block becomes the starting point for step 2.

set NEW_CHECKPOINT  "${DESIGN_NAME}_1_data_setup"
set TEMP_BLOCK      "temp_data_setup"

# ###########################################################################
# 2. Report location for this stage
# ###########################################################################
set STAGE_REPORT_DIR "${PNR_DIR}/step_1_data_setup/reports"

###############################################################################
# End of file
###############################################################################
