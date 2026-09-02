###############################################################################
#
# Script Name : master.tcl
#
# Purpose     : Driver for PnR Step 5 - Clock Tree Synthesis. Builds the clock
#               tree (build + route phases), applies clock routing rules and
#               optimizes up to final_opto.
#
# Flow Stage  : PnR - Step 5 - CTS
#
# Inputs      : ${DESIGN_NAME}_4_place_ends (checkpoint)
#
# Outputs     : ${DESIGN_NAME}_5_clock_ends (checkpoint)
#
# Dependencies: common/*, this folder's modules
#
###############################################################################

set SCRIPT_DIR [file dirname [info script]]
set COMMON_DIR [file normalize "${SCRIPT_DIR}/../../../common"]

source ${COMMON_DIR}/variables.tcl
source ${COMMON_DIR}/design_setup.tcl
source ${COMMON_DIR}/helper_functions.tcl
source ${COMMON_DIR}/common_procedures.tcl


source ${SCRIPT_DIR}/variables.tcl
source ${SCRIPT_DIR}/cts.tcl
source ${SCRIPT_DIR}/checks.tcl
source ${SCRIPT_DIR}/reports.tcl

banner "Step 5 - CTS completed"

# ###########################################################################
# 13. Save the stage checkpoint
# ###########################################################################
save_lb_to_checkpoint $NEW_CHECKPOINT

# ###########################################################################
# 14. Close the library
# .common procedure
# ###########################################################################
close_stage

###############################################################################
# End of file
###############################################################################
