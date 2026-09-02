###############################################################################
#
# Script Name : read_design.tcl
#
# Purpose     : Design entry for Design Compiler: read/analyze RTL, elaborate
#               the top module, link and sanity-check the design.
#
# Flow Stage  : Syn
#
# Dependencies: syn/scripts/variables.tcl
#
# Notes       : Two equivalent design-entry methods are provided.
#               1) List-based read_file (preferred for file lists)
#               2) analyze/elaborate flow 
#
###############################################################################

banner "Reading RTL"

# ###########################################################################
# 1. Design entry  -> using method A . 
# ###########################################################################

# --- Method A : list-based (use when $RTL_FILES is filled in variables.tcl) ---
if {[info exists RTL_FILES] && [llength $RTL_FILES] > 0} {
    foreach rtl_file $RTL_FILES {
        if {[check_file_exists $rtl_file]} {
            read_file -format verilog $rtl_file
        }
    }
    list_designs
    current_design $DESIGN_NAME

} else {
    # --- Method B : analyze / elaborate from a per-file script ---
    if {[check_file_exists $analyze_script]} {
        source $analyze_script
    }
    elaborate $DESIGN_NAME -library work
}

current_design $DESIGN_NAME

# ###########################################################################
# 2. Link and check
# ###########################################################################

link
check_design

# Re-link after check_design
link

###############################################################################
# End of file
###############################################################################
