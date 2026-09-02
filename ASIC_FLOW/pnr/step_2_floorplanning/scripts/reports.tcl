###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Step-2 reports: clock/exception summary, placement and
#               congestion feedback.
#
# Flow Stage  : PnR - Step 2 - Floorplanning
#
# Dependencies: ./variables.tcl
#
###############################################################################

# #############################################################################
# 1. Clocks and exceptions (early sanity)
# #############################################################################
report_clocks -skew -attributes -nosplit  > ${STAGE_REPORT_DIR}/clocks.rpt
report_exceptions                         > ${STAGE_REPORT_DIR}/exceptions.rpt
report_disable_timing           -nosplit  > ${STAGE_REPORT_DIR}/disable_timing.rpt

# ###########################################################################
# 2. Placement / congestion / other reports
# ###########################################################################
report_placement              > ${STAGE_REPORT_DIR}/initial_placement.rpt
report_congestion             > ${STAGE_REPORT_DIR}/congestion.rpt
report_utilization            > ${STAGE_REPORT_DIR}/utilization.rpt

# ###########################################################################
# 3. QoR snapshot + standard reports
# .common procedure
# ###########################################################################
create_qor_snapshot_and_report $STAGE_REPORT_DIR "floorplanning" 

###############################################################################
# End of file
###############################################################################
