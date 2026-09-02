###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Step-6 reports: congestion, QoR snapshot, violations, timing
#               and design summary. Also writes the routed netlist for PT.
#
# Flow Stage  : PnR - Step 6 - Routing
#
# Dependencies: common/common_procedures.tcl, ./variables.tcl
#
###############################################################################

# ###########################################################################
# 1. QoR snapshot + standard reports
# ###########################################################################
create_qor_snapshot_and_report $STAGE_REPORT_DIR "route"

# ###########################################################################
# 2. Congestion report
# ###########################################################################
report_congestion > ${STAGE_REPORT_DIR}/route.congestion.rpt

# ###########################################################################
# 3. Max / min timing reports
# ###########################################################################
report_timing_max_min $STAGE_REPORT_DIR "route"

# ###########################################################################
# 4. Design summary
# ###########################################################################
report_design -all > ${STAGE_REPORT_DIR}/design_summary.rpt

# ###########################################################################
# 5. Routed netlist for PrimeTime
# ###########################################################################
# The PT netlist includes the PG nets so parasitics can be annotated later.
write_verilog -include {pg_netlist} $POST_ROUTE_NETLIST 

###############################################################################
# End of file
###############################################################################
