###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Central definition of every project-specific value.
#               
# Flow Stage  : Common (used by Syn / PnR / Signoff / STA)
#
# Dependencies: Library Setup framework (lib_setup/Master_lib_setup.tcl).
#
###############################################################################

# ###########################################################################
# 1. Project / Design Identity
# ###########################################################################

set ROOT_DIR              "/home/ICer/Mo_AZ/UART_Project"
set DESIGN_NAME           "uart"
set LIBRARY_DIR           "${ROOT_DIR}/pnr/ndm_lib"

# ###########################################################################
# 2. Library Setup framework (single source of truth for the PDK)
# ###########################################################################
# The Library Setup is the authoritative definition of the PDK. It declares
# every technology / library / RC / GDS / LEF path and every special-cell list
# once, and exports them as global variables, e.g.:
#   DESIGN_REF_PATH, Std_cell_lib, Ram_lib, IO_lib, PLL_lib, Ref_lib,
#   Std_cell_gds, Tech_file, Map_file, Gds_map_file, Tlup_max_file,
#   Tlup_min_file, STD_FILLER_CELLS, LINK_LIBRARY_FILES, TARGET_LIBRARY_FILES,
#   ADDITIONAL_SEARCH_PATH, PHYSICAL_REFERENCE_NDM, ...
# The flow scripts only consume those variables; nothing PDK-related is
# re-defined here or anywhere else in the Common Scripts.
#
# library_selection.tcl (sourced below, same section) is the project-level
# SELECTION layer: it picks the active corner per family and aliases the
# Library Setup values into SELECTED_* variables (SELECTED_STD_DB,
# SELECTED_STD_COND, SELECTED_TLUP_MAX_FILE, ...). The flow stages consume
# SELECTED_* exclusively; the Library Setup variables stay untouched.
#
# Absolute path of the Library Setup installation (folder containing
#* Master_lib_setup.tcl "Master file to setup the sead32 ndm lib ").

set LIB_SETUP_DIR         "/home/ICer/Mo_AZ/Common/ALL-LIBs/PDKs_30nm/hierar_NDM_sead_32/lib_setup"

# Load the complete PDK / library configuration.
source "${LIB_SETUP_DIR}/Master_lib_setup.tcl"

# Load the project-level library / corner SELECTION layer. It sits between the
# Library Setup and every flow stage: it only aliases the Library Setup values
# into SELECTED_* variables and never re-defines any PDK path. The flow scripts
# # (SYN / CONS / PnR / STA / FM / Signoff) consume SELECTED_* exclusively.

if {![info exists COMMON_DIR]} { set COMMON_DIR [file dirname [info script]] }
source "${COMMON_DIR}/library_selection.tcl"

# ###########################################################################
# 4. RTL / Constraints / Netlist Inputs
# ###########################################################################

set VERILOG_DIR           "/home/ICer/Mo_AZ/UART_Project/rtl"

# SDC used by DC (hand-written constraints)
set Constraints_file      "${ROOT_DIR}/cons/master.tcl"

# SDC used by ICC2 (output of synthesis)
set Constraints_file_post_syn "${ROOT_DIR}/syn/output/${DESIGN_NAME}_output.sdc"

# Formality SVF output file used to preserve synthesis guidance for equivalence checking
set SVF_file              "${ROOT_DIR}/syn/output/${DESIGN_NAME}_fm.svf"

###############################################################################
# End of file
###############################################################################
