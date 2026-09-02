###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Step-6 specific variables.
#
# Flow Stage  : PnR - Step 6 - Routing
#
# Dependencies: common/variables.tcl
#
###############################################################################

set PNR_DIR               "${ROOT_DIR}/pnr"

# ###########################################################################
# 1. Checkpoint naming
# ###########################################################################
set PREV_CHECKPOINT "${DESIGN_NAME}_5_clock_ends"
set TEMP_BLOCK      "temp_clock_ends"
set NEW_CHECKPOINT  "${DESIGN_NAME}_6_complete"

# ###########################################################################
# 2. Routing options
# ###########################################################################
# Detail-route iterations applied by optimize_routes after route_opt.
set MAX_DETAIL_ROUTE_ITERATIONS 5

# ###########################################################################
# 3. Report location for this stage
# ###########################################################################
set STAGE_REPORT_DIR "${PNR_DIR}/step_6_routing/reports"

# ###########################################################################
# 4. Output netlist used by the post-layout / signoff flow.
# ###########################################################################
# Post-route netlist generated after physical implementation.
# This netlist reflects CTS/routing optimizations and is used for signoff STA analysis in PrimeTime.

set POST_ROUTE_NETLIST  "${PNR_DIR}/step_6_routing/outputs/${DESIGN_NAME}_pt.v"

###############################################################################
# End of file
###############################################################################
