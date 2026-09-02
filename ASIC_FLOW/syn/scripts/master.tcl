###############################################################################
#
# Script Name : master.tcl
#
# Purpose     : Top-level driver for the Design Compiler synthesis flow.
#               Sources every synthesis module in the correct order.
#
# Flow Stage  : Syn
#
# Inputs      : RTL files, constraints file (both configured in variables.tcl)
#
# Dependencies: common/variables.tcl, common/design_setup.tcl,
#               all modules of this folder
#
###############################################################################

# ###########################################################################
# 0. Resolve paths and source the common modules
# ###########################################################################
# [info script] makes the paths robust regardless of the directory from which
# the tool is launched.


set SCRIPT_DIR [file dirname [info script]]
# Directory containing THIS script (independent of the current working directory).

set COMMON_DIR [file normalize "${SCRIPT_DIR}/../../common"]
# Shared "common" folder used by this flow (variables, helper functions, design setup, etc.).

source ${COMMON_DIR}/variables.tcl

source ${COMMON_DIR}/helper_functions.tcl

source ${COMMON_DIR}/common_procedures.tcl

source ${COMMON_DIR}/design_setup.tcl

source ${SCRIPT_DIR}/variables.tcl


# ###########################################################################
# 1. Define the working library directory
# ###########################################################################
# The 'work' library holds analyzed RTL (DC internal format).
###############################* /home/ICer/Mo_AZ/UART_Project/syn/work
define_design_lib work -path ./work    

# ###########################################################################
# 2. Libraries setup
# ###########################################################################
source ${SCRIPT_DIR}/libraries_setup.tcl

# ###########################################################################
# 3. Read RTL / design entry
# ###########################################################################
source ${SCRIPT_DIR}/read_design.tcl

# Record synthesis transformations and mapping guidance for Formality
# in the SVF file used for subsequent RTL-to-netlist equivalence checking.
set_svf ${SVF_file}

# ###########################################################################
# 4. Constraints and path groups
# ###########################################################################
source ${SCRIPT_DIR}/constraints_setup.tcl

# ###########################################################################
# 5. Compile (strategy selectable via the COMPILE_STRATEGY variable)
# ###########################################################################
source ${SCRIPT_DIR}/compile_strategies.tcl

# ###########################################################################
# 6. Reports
# ###########################################################################
source ${SCRIPT_DIR}/reports.tcl

# ###########################################################################
# 7. Write outputs
# ###########################################################################
source ${SCRIPT_DIR}/save_outputs.tcl

banner "Synthesis flow completed"

# ###############################################################################
# # End of file
# ###############################################################################
