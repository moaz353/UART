###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Step-4 reports: QoR snapshot, QoR summary, constraint
#               violations and max/min timing.
#
# Flow Stage  : PnR - Step 4 - Placement
#
# Dependencies: common/common_procedures.tcl, ./variables.tcl
#
###############################################################################

# ###########################################################################
# 1. QoR snapshot + standard reports
# ###########################################################################
# The snapshot name doubles as the report-file basename (placement.*).
create_qor_snapshot_and_report $STAGE_REPORT_DIR "placement"

# ###########################################################################
# 2. Max / min timing reports
# ###########################################################################
report_timing_max_min $STAGE_REPORT_DIR "placement"

###############################################################################
# End of file
###############################################################################
