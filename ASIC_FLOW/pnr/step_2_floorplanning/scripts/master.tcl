###############################################################################
#
# Script Name : master.tcl
#
# Purpose     : Driver for PnR Step 2 - Floorplanning. Initializes the die/core
#               floorplan, defines preferred routing directions, places pins,
#               runs an initial floorplan placement and saves the checkpoint.
#
# Flow Stage  : PnR - Step 2 - Floorplanning
#
# Inputs      : ${DESIGN_NAME}_1_data_setup (checkpoint)
#
# Outputs     : ${DESIGN_NAME}_2_floorplan_ends (checkpoint)
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
source ${SCRIPT_DIR}/floorplan.tcl
source ${SCRIPT_DIR}/checks.tcl
source ${SCRIPT_DIR}/reports.tcl

# ###########################################################################
# Save the stage checkpoint
###########################################################################
save_lb_to_checkpoint $NEW_CHECKPOINT

###########################################################################
# Close the library
# .common procedure
###########################################################################
close_stage

banner "Step 2 - Floorplanning completed"

###############################################################################
# End of file
###############################################################################
