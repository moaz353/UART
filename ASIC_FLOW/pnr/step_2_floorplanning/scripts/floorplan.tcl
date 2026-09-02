###############################################################################
#
# Script Name : floorplan.tcl
#
# Purpose     : Step-2 core work: power/GND net definition, preferred routing
#               directions, floorplan initialization, pin placement and an
#               initial floorplan placement.
#
# Flow Stage  : PnR - Step 2 - Floorplanning
#
# Inputs      : ${DESIGN_NAME}_1_data_setup checkpoint (open in temp block)
#
# Outputs     : Floorplanized, initially-placed design; saved as
#               ${DESIGN_NAME}_2_floorplan_ends
#
# Dependencies: common/common_procedures.tcl, ./save_restore.tcl
#
###############################################################################

# ###########################################################################
# 1. Open previous checkpoint (copy to temp, open temp) .
# _common procsedure
# ###########################################################################
open_lb_from_checkpoint $PREV_CHECKPOINT $TEMP_BLOCK

# ###########################################################################
# 2. Clock / exception sanity reports
# ###########################################################################
report_clocks -skew -attributes 
report_exceptions              
report_disable_timing  

# ###########################################################################
# 3. Power/Ground net naming
# ###########################################################################
# Define the power/ground net names and the NDM logic-0/logic-1 tie nets.

set power            $POWER_NET
set ground           $GROUND_NET
set powerPort        $POWER_PORT
set groundPort       $GROUND_PORT
set ndm_logic0_net   $GROUND_NET
set ndm_logic1_net   $POWER_NET

# ###########################################################################
# 4. Timing options and path groups
# ###########################################################################
# Recovery/removal and case-analysis checks are enabled so that timing seen
# during floorplanning matches signoff assumptions.

set_app_option -name time.disable_recovery_removal_checks -value false
set_app_option -name time.disable_case_analysis          -value false

# .common procedure
setup_path_groups

# ###########################################################################
# 5. Preferred routing directions
# ###########################################################################
# Restrict signal routing to the routing layer budget and set the preferred
# direction of every metal layer (alternating V/H is mandatory for good
# track utilization). 

set_ignored_layers -min_routing_layer ${route_min_layer} -max_routing_layer ${pns_hlayer}  

set_attribute [get_layers M1] routing_direction horizontal
set_attribute [get_layers M2] routing_direction vertical
set_attribute [get_layers M3] routing_direction horizontal
set_attribute [get_layers M4] routing_direction vertical
set_attribute [get_layers M5] routing_direction horizontal
set_attribute [get_layers M6] routing_direction vertical
set_attribute [get_layers M7] routing_direction horizontal

# ###########################################################################
# 6. Initialize the floorplan
# ###########################################################################
# Place the M1 rail tracks on the exact PDK grid first, then create the core
# at the requested utilization. `-flip_first_row` alternates row orientation
# (VDD/VSS rails shared between rows).

set_wire_track_pattern -site_def unit -layer $WIRE_TRACK_LAYER \
    -mode uniform \
    -mask_constraint {mask_two mask_one} \
    -coord $WIRE_TRACK_COORD \
    -space $WIRE_TRACK_SPACE \
    -direction vertical

initialize_floorplan -core_utilization $CORE_UTILIZATION \
                        -flip_first_row true \
                        -core_offset $CORE_OFFSET

# ###########################################################################
# 7. Port (pin) placement
# ###########################################################################
# Auto-place IO ports around the boundary.

place_pins -ports [get_ports *]

# ###########################################################################
# 9. Power/Ground net typing
# ###########################################################################
# Mark VDD/VSS net types so powerplanning and later PG connectivity work.
set_attribute -objects [get_nets $power]  -name net_type -value power
set_attribute -objects [get_nets $ground] -name net_type -value ground
check_mv_design

# ###########################################################################
# 10. Initial floorplan placement
# ###########################################################################
# Places macros and standard cells roughly to evaluate congestion/legality,
# then runs a congestion-only global route for early planning feedback.

create_placement -floorplan -effort high -timing_driven
legalize_placement
route_global -congestion_map_only true -effort high

report_placement  

###############################################################################
# End of file
###############################################################################
