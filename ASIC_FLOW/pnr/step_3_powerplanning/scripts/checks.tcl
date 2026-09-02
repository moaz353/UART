###############################################################################
#
# Script Name : checks.tcl
#
# Purpose     : Step-3 checks: PG connectivity, PG DRC, missing vias,
#               multi-voltage consistency and library report.
#
# Flow Stage  : PnR - Step 3 - Power Planning
#
# Dependencies: ./variables.tcl
#
###############################################################################

ensure_directory $STAGE_REPORT_DIR

# ###########################################################################
# 1. Library report
# ###########################################################################
report_lib $ARCH_TOP_NDM > ${STAGE_REPORT_DIR}/ndm_lib.rpt

# ###########################################################################
# 2. PG connectivity check
# ###########################################################################
# Verifies that the power and ground networks are properly connected.
check_pg_connectivity -nets "$POWER_NET $GROUND_NET" > ${STAGE_REPORT_DIR}/pg_connectivity.rpt

# ###########################################################################
# 3. PG DRC check
# ###########################################################################
# Checks the generated PG network against applicable technology rules.
check_pg_drc > ${STAGE_REPORT_DIR}/pg_drc.rpt

# ###########################################################################
# 4. PG missing-via check
# ###########################################################################
# Checks the PG network for missing vias between connected PG shapes.
check_pg_missing_vias > ${STAGE_REPORT_DIR}/pg_missing_vias.rpt

# ###########################################################################
# 5. Multi-voltage design check
# ###########################################################################
check_mv_design > ${STAGE_REPORT_DIR}/mv_design.rpt

###############################################################################
# End of file
###############################################################################