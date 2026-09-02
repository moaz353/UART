###############################################################################
#
# Script Name : checks.tcl
#
# Purpose     : Step-7 physical and connectivity checks:
#               library, multi-voltage, LVS, legality, design consistency,
#               and final PG connectivity.
#
# Flow Stage  : PnR - Step 7 - Finishing
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
# 2. Multi-voltage consistency
# ###########################################################################
check_mv_design > ${STAGE_REPORT_DIR}/mv_design.rpt

# ###########################################################################
# 3. Final LVS
# ###########################################################################
check_lvs -max_errors 15000 > ${STAGE_REPORT_DIR}/${DESIGN_NAME}.lvs.rpt

# ###########################################################################
# 4. Design legality check
# ###########################################################################
check_legality > ${STAGE_REPORT_DIR}/${DESIGN_NAME}.final_legality.rpt

# ###########################################################################
# 5. Power / Ground connectivity
# ###########################################################################
# Verifies that the power and ground network is properly connected.
check_pg_connectivity > ${STAGE_REPORT_DIR}/${DESIGN_NAME}.final_pg_connectivity.rpt

###############################################################################
# End of file
###############################################################################
