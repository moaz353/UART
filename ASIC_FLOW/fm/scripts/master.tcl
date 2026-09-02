###############################################################################
#
# Script Name : master.tcl
#
# Purpose     : Driver for the Formality (FM) equivalence-check flow: set up
#               the Reference (RTL) and Implementation (netlist) containers,
#               match, verify and report.
#
###############################################################################

set SCRIPT_DIR [file dirname [info script]]
set COMMON_DIR [file normalize "${SCRIPT_DIR}/../common"]


source ${SCRIPT_DIR}/variables.tcl
source ${SCRIPT_DIR}/fm_verify.tcl
source ${SCRIPT_DIR}/reports.tcl

puts "Formality flow completed"

# start_gui   ;# uncomment to launch the FM GUI at the end

# exit

###############################################################################
# End of file
###############################################################################
