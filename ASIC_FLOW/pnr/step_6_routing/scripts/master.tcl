###############################################################################
#
# Script Name : master.tcl
#
# Purpose     : Driver for PnR Step 6 - Routing. Runs global + detail routing
#               (route_auto, route_opt), optimizes the routed design and saves
#               the checkpoint.
#
# Flow Stage  : PnR - Step 6 - Routing
#
# Inputs      : ${DESIGN_NAME}_5_clock_ends (checkpoint)
#
# Outputs     : ${DESIGN_NAME}_6_complete (checkpoint)
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
source ${SCRIPT_DIR}/routing.tcl
source ${SCRIPT_DIR}/checks.tcl
source ${SCRIPT_DIR}/reports.tcl

banner "Step 6 - Routing completed"

# ###########################################################################
#  Save the stage checkpoint
# ###########################################################################
save_lb_to_checkpoint $NEW_CHECKPOINT

# ###########################################################################
#  Close the library
# .common procedure
# ###########################################################################
# close_stage

###############################################################################
# End of file
###############################################################################
