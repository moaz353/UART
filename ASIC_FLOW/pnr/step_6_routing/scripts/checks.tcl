###############################################################################
#
# Script Name : checks.tcl
#
# Purpose     : Step-6 checks: in-design LVS, route and legality verification.
#
# Flow Stage  : PnR - Step 6 - Routing
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
# 2. In-design LVS check
# ###########################################################################
# Catches opens/shorts early; the real LVS signoff happens in finishing/signoff.
check_lvs -max_errors 2000 > ${STAGE_REPORT_DIR}/route_lvs.rpt

# ###########################################################################
# 3. Route / legality checks
# ###########################################################################
check_routes   > ${STAGE_REPORT_DIR}/op_check_route.rpt
check_legality > ${STAGE_REPORT_DIR}/op_legality.rpt

###############################################################################
# End of file
###############################################################################
