###############################################################################
#
# Script Name : master.tcl
#
# Purpose     : Driver for PnR Step 1 - Data Setup. Creates the NDM design
#               library, imports the gate-level netlist, applies constraints
#               and saves the first checkpoint.
#
# Flow Stage  : PnR - Step 1 - Data Setup
#
# Inputs      : Gate-level netlist ($Core_compile), constraints ($Constraints_file)
#
# Outputs     : ${DESIGN_NAME}_1_data_setup (checkpoint in $ARCH_TOP_NDM)
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
source ${SCRIPT_DIR}/data_setup.tcl
source ${SCRIPT_DIR}/checks.tcl
source ${SCRIPT_DIR}/reports.tcl

# ###########################################################################
# 3. Close the stage
# .common procedure
# ###########################################################################
close_stage

banner "Step 1 - Data Setup completed"

###############################################################################
# End of file
###############################################################################
