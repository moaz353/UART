###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Standard Design Compiler reporting block.
#
# Flow Stage  : Syn
#
# Outputs     : Report files under /${SYN_REPORT_DIR}
#
# Dependencies: common/helper_functions.tcl
#
###############################################################################

banner "Reporting"

ensure_directory "${SYN_REPORT_DIR}"
ensure_directory "${SYN_QOR_DIR}"

# ###########################################################################
# 1. Core QoR reports
# ###########################################################################

# Setup / hold timing, top 10 paths each, no line splitting.
report_timing -max_paths 10 -delay_type max -nosplit > ${SYN_QOR_DIR}/${DESIGN_NAME}_timing_setup.rpt

report_timing -max_paths 10 -delay_type min -nosplit > ${SYN_QOR_DIR}/${DESIGN_NAME}_timing_hold.rpt

# QoR summary (WNS/TNS, cell counts, area, design rules).
report_qor > ${SYN_QOR_DIR}/${DESIGN_NAME}_qor.rpt

# Hierarchical area and power breakdown.
report_area  -hierarchy > ${SYN_QOR_DIR}/${DESIGN_NAME}_area.rpt
report_power -hierarchy > ${SYN_QOR_DIR}/${DESIGN_NAME}_power.rpt

# ###########################################################################
# 2. Extended reports 
# ###########################################################################

report_clock -attributes              > ${SYN_REPORT_DIR}/${DESIGN_NAME}_clocks.rpt
report_constraint -all_violators      > ${SYN_REPORT_DIR}/${DESIGN_NAME}_constraints.rpt
report_cell                           > ${SYN_REPORT_DIR}/${DESIGN_NAME}_cell_usage.rpt
report_reference                      > ${SYN_REPORT_DIR}/${DESIGN_NAME}_reference_usage.rpt
report_port                           > ${SYN_REPORT_DIR}/${DESIGN_NAME}_ports.rpt
report_hierarchy                      > ${SYN_REPORT_DIR}/${DESIGN_NAME}_hierarchy.rpt
report_design                         > ${SYN_REPORT_DIR}/${DESIGN_NAME}_design_summary.rpt
report_timing_requirements            > ${SYN_REPORT_DIR}/${DESIGN_NAME}_timing_reqs.rpt
report_case_analysis                  > ${SYN_REPORT_DIR}/${DESIGN_NAME}_case_analysis.rpt

###############################################################################
# End of file
###############################################################################
