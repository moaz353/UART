###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Step-5 reports: pre-route and post-route QoR snapshots plus
#               max/min timing after both clock_opt phases.
#
# Flow Stage  : PnR - Step 5 - CTS
#
# Dependencies: common/common_procedures.tcl, ./variables.tcl
#
###############################################################################

# ###########################################################################
# 1. Pre-route snapshot reports (after build_clock)
# ###########################################################################
report_qor_snapshot -name clock_pre_route > ${CLOCK_PRE_ROUTE_QOR_DIR}/clock_pre_route.qor_snapshot.rpt
report_qor                                > ${CLOCK_PRE_ROUTE_QOR_DIR}/clock_pre_route.qor
report_constraints -all_violators         > ${CLOCK_PRE_ROUTE_QOR_DIR}/clock_pre_route.con

report_timing -capacitance -transition_time -input_pins -nets \
                -delay_type max -path full > ${CLOCK_PRE_ROUTE_TIMING_DIR}/clock_pre_route.max.tim
report_timing -capacitance -transition_time -input_pins -nets \
                -delay_type min -path full > ${CLOCK_PRE_ROUTE_TIMING_DIR}/clock_pre_route.min.tim

# ###########################################################################
# 2. Post-route QoR snapshot + standard reports + Max / min timing reports (after route_clock -> final_opto)
# ###########################################################################

create_qor_snapshot_and_report $STAGE_REPORT_DIR "clock"

report_timing_max_min $STAGE_REPORT_DIR "clock"

# ###########################################################################
# 3. Clock-tree specific reports
# ###########################################################################
report_clocks                  > ${STAGE_REPORT_DIR}/clocks.rpt
report_clock_qor               > ${STAGE_REPORT_DIR}/clock_tree.rpt
report_clock_timing -type skew > ${STAGE_REPORT_DIR}/clock_timing.rpt
report_clock_routing_rules     > ${STAGE_REPORT_DIR}/clock_routing_rules.rpt

# ###########################################################################
# 4. Clock SDC for the routing stage
# ###########################################################################
write_sdc -output ${STAGE_OUTPUT_DIR}/design.sdc

###############################################################################
# End of file
###############################################################################