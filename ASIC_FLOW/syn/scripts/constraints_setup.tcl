###############################################################################
#
# Script Name : constraints_setup.tcl
#
# Purpose     : Apply design constraints (SDC) and define timing path groups.
#
# Flow Stage  : Syn
#
# Dependencies: common/common_procedures.tcl (setup_path_groups)
#
###############################################################################

banner "Design constraints"

# ###########################################################################
# 1. Read the SDC
# ###########################################################################
# Source (not read_sdc) so Tcl variable expansion and comments are honored.

require_file $Constraints_file
source -echo $Constraints_file

# ###########################################################################
# 2. Path groups
# ###########################################################################
# Grouping paths (INREG / REGOUT / INOUT) makes report_timing much easier to
# read because every report lists per-group WNS/TNS instead of one global view.
# .common procedure

setup_path_groups

###############################################################################
# End of file
###############################################################################
