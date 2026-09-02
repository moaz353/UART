###############################################################################
#
# Script Name : powerplanning.tcl
#
# Purpose     : Step-3 core work: create and compile the PG network — standard
#               cell rails, three-stage mesh and power ring — then verify PG
#               connectivity.
#
# Flow Stage  : PnR - Step 3 - Power Planning
#
# Inputs      : ${DESIGN_NAME}_2_floorplan_ends checkpoint (open in temp block)
#
# Outputs     : Routed PG network; saved as ${DESIGN_NAME}_3_powerplan_ends
#
# Dependencies: common/common_procedures.tcl, ./save_restore.tcl
#
###############################################################################

# ###########################################################################
# 1. Open previous checkpoint (copy to temp, open temp)
# ###########################################################################
open_lb_from_checkpoint $PREV_CHECKPOINT $TEMP_BLOCK

# ###########################################################################
# 2. PG nets and physical pin connection
# ###########################################################################
# Setup_pg_nets (common) creates/keeps the VDD/VSS nets, sets their net_type
# and connects every physical PG pin to them.

setup_pg_nets $POWER_NET $GROUND_NET

# ###########################################################################
# 3. Clean any pre-existing PG rules
# ###########################################################################
# Always reset patterns/strategies/via-rules so the script is re-runnable and
# no stale strategy from a previous iteration interferes.

remove_pg_via_master_rules -all
remove_pg_patterns        -all
remove_pg_strategies      -all
remove_pg_strategy_via_rules -all

# ###########################################################################
# 4. Standard-cell rail pattern (M1)
# ###########################################################################
# @wtop/@wbottom are parameters of the pattern; they are bound per-net when
# the strategy is created below (VDD rail vs VSS rail in the same row pitch).

create_pg_std_cell_conn_pattern $RAIL_PATTERN_NAME \
    -layers {M1} \
    -rail_width {@wtop @wbottom} \
    -parameters {wtop wbottom}

set_pg_strategy ${RAIL_PATTERN_NAME}_strategy_pwr \
    -core \
    -pattern [list \
        [list name: $RAIL_PATTERN_NAME] \
        [list nets: $POWER_NET] \
        [list parameters: $RAIL_WIDTH]]                              
set_pg_strategy ${RAIL_PATTERN_NAME}_strategy_gnd \
    -core \
    -pattern [list \
        [list name: $RAIL_PATTERN_NAME] \
        [list nets: $GROUND_NET] \
        [list parameters: $RAIL_WIDTH]] 

compile_pg -strategies ${RAIL_PATTERN_NAME}_strategy_pwr $PG_COMPILE_MODE
compile_pg -strategies ${RAIL_PATTERN_NAME}_strategy_gnd $PG_COMPILE_MODE

# ###########################################################################
# 5. Middle horizontal mesh
# ###########################################################################
create_pg_mesh_pattern MID_MESH_HORIZONTAL \
    -layers "
        { {horizontal_layer: $MESH_MID_LAYER} {width: $MESH_MID_WIDTH} {spacing: interleaving} {pitch: $MESH_MID_PITCH} {offset: $MESH_OFFSET} {trim : true} }
    "

set_pg_strategy VDDVSS_MID_MESH_HORIZONTAL \
    -core \
    -pattern   { {name: MID_MESH_HORIZONTAL} {nets:{VSS VDD}} } \
    -extension { {{stop:design_boundary_and_generate_pin}} }

compile_pg -strategies VDDVSS_MID_MESH_HORIZONTAL $PG_COMPILE_MODE

# ###########################################################################
# 6. Top vertical mesh
# ###########################################################################
create_pg_mesh_pattern TOP_MESH_VERTICAL \
    -layers "
        { {vertical_layer: $MESH_TOP_V_LAYER} {width: $MESH_TOP_V_WIDTH} {spacing: interleaving} {pitch: $MESH_TOP_V_PITCH} {offset: $MESH_OFFSET} {trim : true} }
    "

set_pg_strategy VDDVSS_TOP_MESH_VERTICAL \
    -core \
    -pattern   { {name: TOP_MESH_VERTICAL} {nets:{VSS VDD}} } \
    -extension { {{stop:design_boundary_and_generate_pin}} }

compile_pg -strategies VDDVSS_TOP_MESH_VERTICAL $PG_COMPILE_MODE

# ###########################################################################
# 7. Top horizontal mesh
# ###########################################################################
create_pg_mesh_pattern TOP_MESH_HORIZONTAL \
    -layers "
        { {horizontal_layer: $MESH_TOP_H_LAYER} {width: $MESH_TOP_H_WIDTH} {spacing: interleaving} {pitch: $MESH_TOP_H_PITCH} {offset: $MESH_OFFSET} {trim : true} }
    "

set_pg_strategy VDDVSS_TOP_MESH_HORIZONTAL \
    -core \
    -pattern   { {name: TOP_MESH_HORIZONTAL} {nets:{VSS VDD}} } \
    -extension { {{stop:design_boundary_and_generate_pin}} }

compile_pg -strategies VDDVSS_TOP_MESH_HORIZONTAL $PG_COMPILE_MODE

# ###########################################################################
# 8. Rectangular power ring
# ###########################################################################
# A ring around the core stitches the mesh and provides low-impedance current
# delivery at the boundary.

create_pg_ring_pattern ring_pattern \
    -horizontal_layer $RING_H_LAYER -vertical_layer $RING_V_LAYER \
    -horizontal_width $RING_H_WIDTH -vertical_width $RING_V_WIDTH \
    -horizontal_spacing $RING_H_SPACE -vertical_spacing $RING_V_SPACE

set_pg_strategy RING -core -pattern {{ name: ring_pattern} { nets: "VDD VSS" }}

compile_pg -strategies RING $PG_COMPILE_MODE

# ###########################################################################
# 9. Verify PG connectivity
# ###########################################################################
check_pg_connectivity -nets "$POWER_NET $GROUND_NET"

# ###############################################################################
# # End of file
# ###############################################################################
