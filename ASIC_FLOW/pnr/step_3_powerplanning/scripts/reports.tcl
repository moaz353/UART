###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Step-3 reports: PG patterns, strategies and via rules.
#
# Flow Stage  : PnR - Step 3 - Power Planning
#
# Dependencies: ./variables.tcl
#
###############################################################################

ensure_directory $STAGE_REPORT_DIR

# ###########################################################################
# 1. PG pattern report
# ###########################################################################
# Reports the PG patterns defined for power planning.
report_pg_patterns > ${STAGE_REPORT_DIR}/pg_patterns.rpt

# ###########################################################################
# 2. PG strategy report
# ###########################################################################
# Reports the PG strategies used to generate the power network.
report_pg_strategies > ${STAGE_REPORT_DIR}/pg_strategies.rpt

# ###########################################################################
# 3. PG strategy via-rule report
# ###########################################################################
# Reports via rules associated with PG strategies.
report_pg_strategy_via_rules > ${STAGE_REPORT_DIR}/pg_strategy_via_rules.rpt

# ###########################################################################
# 4. PG via-master-rule report
# ###########################################################################
# Reports the PG via master rules available for PG generation.
report_pg_via_master_rules > ${STAGE_REPORT_DIR}/pg_via_master_rules.rpt

# ###########################################################################
# 5. QoR snapshot + standard reports
# .common procedure
# ###########################################################################
create_qor_snapshot_and_report $STAGE_REPORT_DIR "powerplanning"

###############################################################################
# End of file
###############################################################################