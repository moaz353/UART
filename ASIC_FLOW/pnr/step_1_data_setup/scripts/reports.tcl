###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Step-1 reports. At this point timing is not meaningful yet
#               (no placement), so reports are limited to design summaries.
#
# Flow Stage  : PnR - Step 1 - Data Setup
#
#
# Dependencies: ./variables.tcl
#
###############################################################################

# ###########################################################################
# 1. Design summary
# ###########################################################################
report_design -all > ${STAGE_REPORT_DIR}/${DESIGN_NAME}_design_summary.rpt

# ###########################################################################
# 2. (Optional) Reference library / cell counts
# ###########################################################################
report_cell [get_cells -hierarchical *] > ${STAGE_REPORT_DIR}/${DESIGN_NAME}_all_cell_usage.rpt

###############################################################################
# End of file
###############################################################################
