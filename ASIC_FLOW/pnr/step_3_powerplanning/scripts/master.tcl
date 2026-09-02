###############################################################################
#
# Script Name : master.tcl
#
# Purpose     : Driver for PnR Step 3 - Power Planning. Creates the PG network
#               (std-cell rails, mesh, ring), connects PG pins and saves the
#               checkpoint.
#
# Flow Stage  : PnR - Step 3 - Power Planning
#
# Inputs      : ${DESIGN_NAME}_2_floorplan_ends (checkpoint)
#
# Outputs     : ${DESIGN_NAME}_3_powerplan_ends (checkpoint)
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
source ${SCRIPT_DIR}/powerplanning.tcl
source ${SCRIPT_DIR}/checks.tcl
source ${SCRIPT_DIR}/reports.tcl

# ###########################################################################
# Save the stage checkpoint
###########################################################################
save_lb_to_checkpoint $NEW_CHECKPOINT

##########################################################################
# Close the library
# .common procedure
##########################################################################
close_stage

banner "Step 3 - Power Planning completed"

###############################################################################
# End of file
###############################################################################
