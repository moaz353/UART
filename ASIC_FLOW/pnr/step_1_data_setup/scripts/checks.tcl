###############################################################################
#
# Script Name : checks.tcl
#
# Purpose     : Step-1 sanity checks: confirm the library and the imported
#               design are consistent.
#
# Flow Stage  : PnR - Step 1 - Data Setup
#
# Dependencies: ./variables.tcl
#
###############################################################################

ensure_directory $STAGE_REPORT_DIR

# ###########################################################################
# 1. Library report
# ###########################################################################
# Confirms the NDM library content (blocks, reference libs, tech file).

report_lib $ARCH_TOP_NDM > ${STAGE_REPORT_DIR}/ndm_lib.rpt

# ###########################################################################
# 2. Design sanity
# ###########################################################################
# Verify the imported netlist links against the reference libraries.
  report_net    -nosplit > ${STAGE_REPORT_DIR}/nets.rpt
  report_cell   -nosplit > ${STAGE_REPORT_DIR}/cells.rpt

# ###########################################################################
# 3. Constraint sanity
# ###########################################################################
# Confirm clocks and constraints were read correctly before optimization.
  report_clocks -skew -attributes > ${STAGE_REPORT_DIR}/clocks.rpt

###############################################################################
# End of file
###############################################################################
