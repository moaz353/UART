###############################################################################
#
# Script Name : routing.tcl
#
# Purpose     : Step-6 core work: run global + detail routing (route_auto),
#               post-route optimization (route_opt), fix remaining DRCs with
#               optimize_routes and run an in-design LVS check.
#
# Flow Stage  : PnR - Step 6 - Routing
#
# Inputs      : ${DESIGN_NAME}_5_clock_ends checkpoint (open in temp block)
#
# Outputs     : Routed design; saved as ${DESIGN_NAME}_6_complete
#
# Dependencies: common/mcmm.tcl, common/common_procedures.tcl,
#               ./save_restore.tcl
#
###############################################################################

# ###########################################################################
# 1. Open previous checkpoint (copy to temp, open temp)
# ###########################################################################
open_lb_from_checkpoint $PREV_CHECKPOINT $TEMP_BLOCK


# ###########################################################################
# 2. Routing layer budget
# ###########################################################################
set_ignored_layers -min_routing_layer ${route_min_layer} \
                    -max_routing_layer ${route_max_layer}
report_ignored_layers

# ###########################################################################
# 3. MCMM setup
# ###########################################################################
# Routing and post-route optimization are timing-aware; MCMM gives the
# optimizer the corners/scenarios to analyze.
source ${COMMON_DIR}/mcmm.tcl

# ###########################################################################
# 4. Global + detail routing
# ###########################################################################
route_auto

# ###########################################################################
# 5. Post-route optimization
# ###########################################################################
# Fixes timing, DRCs and SI violations introduced by real wire delays.
route_opt

# ###########################################################################
# 6. PG connection (route_opt may have inserted cells)
# ###########################################################################
setup_pg_nets $POWER_NET $GROUND_NET

# ###########################################################################
# 7. Detail-route DRC fixing
# ###########################################################################
# Re-routes a limited number of iterations to clean remaining DRCs
# (min-spacing, end-of-line, ...).
optimize_routes -max_detail_route_iterations $MAX_DETAIL_ROUTE_ITERATIONS

###############################################################################
# End of file
###############################################################################
