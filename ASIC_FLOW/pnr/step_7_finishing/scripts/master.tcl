###############################################################################
#
# Script Name : master.tcl
#
# Purpose     : Driver for PnR Step 7 - Finishing. Inserts redundant vias,
#               fillers and metal fill, runs final checks and writes every
#               output artifact (Verilog / SDC / SPEF / DEF / GDS).
#
# Flow Stage  : PnR - Step 7 - Finishing
#
# Inputs      : ${DESIGN_NAME}_6_complete (checkpoint)
#
# Outputs     : ${DESIGN_NAME}_7_finished (checkpoint), all stream outputs
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
source ${SCRIPT_DIR}/finishing.tcl
source ${SCRIPT_DIR}/checks.tcl
source ${SCRIPT_DIR}/reports.tcl

banner "Step 7 - Finishing completed"

# ###########################################################################
#  Save 
# .common procedure
# ###########################################################################
save_lb_to_checkpoint $NEW_CHECKPOINT

# ###########################################################################
#  close
# .common procedure
# ###########################################################################

close_stage

###############################################################################
# End of file
###############################################################################
