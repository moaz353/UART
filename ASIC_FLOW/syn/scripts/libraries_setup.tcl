###############################################################################
#
# Script Name : libraries_setup.tcl
#
# Purpose     : Design Compiler library configuration: search path, target and
#               link libraries, and synthesis-specific tool settings.
#
# Flow Stage  : Syn
#
# Dependencies: common/variables.tcl, common/design_setup.tcl
#
###############################################################################

banner "Library setup"

# ###########################################################################
# 1. Search path
# ###########################################################################

set search_path ". ${search_path} ${VERILOG_DIR}"

# ###########################################################################
# 2. Target and link libraries
# ###########################################################################

set target_library "$SELECTED_TARGET_LIBRARY_FILES"
set link_library   "$SELECTED_LINK_LIBRARY_FILES"

# ###########################################################################
# 3. Synthesis-specific settings
# ###########################################################################

# Keep power/ground ports from the RTL (multi-voltage ready design).
set_app_var dc_allow_rtl_pg true

# Netlist readability: avoid driving buses with assign statements.
# (Apply BEFORE compile so it affects the generated netlist.)
set_fix_multiple_port_nets -outputs -feedthroughs -buffer_constants

###############################################################################
# End of file
###############################################################################
