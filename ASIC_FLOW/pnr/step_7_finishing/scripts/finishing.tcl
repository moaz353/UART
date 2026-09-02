###############################################################################
#
# Script Name : finishing.tcl
#
# Purpose     : Step-7 core work: physical finishing of the routed design —
#               redundant vias, standard-cell fillers, metal fill, final PG
#               connection, in-design LVS and the write-out of every final
#               artifact (Verilog / SDC / SPEF / DEF / GDS).
#
# Flow Stage  : PnR - Step 7 - Finishing
#
# Inputs      : ${DESIGN_NAME}_6_complete checkpoint (open in temp block)
#
# Outputs     : ${DESIGN_NAME}_7_finished checkpoint + stream outputs
#
# Dependencies: common/common_procedures.tcl, ./save_restore.tcl
#
###############################################################################

# ###########################################################################
# 1. Open previous checkpoint (copy to temp, open temp)
# ###########################################################################
open_lb_from_checkpoint $PREV_CHECKPOINT $TEMP_BLOCK


# ###########################################################################
# 2. Insert redundant vias
# ###########################################################################
# Replaces single-cut vias with multi-cut vias where possible. Improves yield
# and reliability (Electromigration) with almost no area cost.
add_redundant_vias

# ###########################################################################
# 3. Insert standard-cell fillers
# ###########################################################################
# Fillers fill empty row sites so the design has no gaps (needed for well/tap
# continuity, metal density and LVS). They are physical-only cells.
#
# Two equivalent styles are shown. The list-based form is preferred because it
# reads from $STD_FILLER_CELLS.

create_stdcell_fillers \
    -lib_cells [prefix_list $STD_FILLER_CELLS]

# ###########################################################################
# 4. Final PG connection and multi-voltage check
# ###########################################################################
setup_pg_nets $POWER_NET $GROUND_NET

# ###########################################################################
# 6. Final output writing (used in finishing)
# ###########################################################################
# Writes every artifact a downstream tool needs:
#   - Verilog netlist with / without PG nets and physical-only cells
#   - SDC for the back-annotated design
#   - SPEF parasitics (later corners appended by StarRC)
#   - DEF physical layout
#
banner "Write output files (Verilog / SDC / SPEF / DEF )"

# Verilog Netlist
# Gate-level netlist including the PG nets for LVS/PT runs.
write_verilog -include {pg_netlist unconnected_ports} ${STAGE_OUTPUT_DIR}/${DESIGN_NAME}.pg.v

# Verilog Netlist
# Netlist without physical-only cells (fillers, decaps) for simulation.
write_verilog -exclude {physical_only_cells} ${STAGE_OUTPUT_DIR}/${DESIGN_NAME}.v

# SDC 
write_sdc -output ${STAGE_OUTPUT_DIR}/${DESIGN_NAME}.out.sdc

# SPEF
# Report the crosstalk delta before writing SPEF.
report_timing -crosstalk_delta

write_parasitics -format SPEF -output ${STAGE_OUTPUT_DIR}/${DESIGN_NAME}.out.spef

# DEF
write_def ${STAGE_OUTPUT_DIR}/${DESIGN_NAME}.out.def

# ###########################################################################
# 7. GDSII stream-out
# ###########################################################################
# Save the final named checkpoint first, then stream it to GDS with the PDK
# layer map and the merged std-cell GDS.
save_block -as $NEW_CHECKPOINT

banner "Write GDSII stream"

write_gds -design ${DESIGN_NAME}_7_finished \
            -layer_map $SELECTED_GDS_MAP_FILE \
            -keep_data_type \
            -fill include \
            -output_pin all \
            -merge_files $SELECTED_STD_GDS \
            -long_names ${STAGE_OUTPUT_DIR}/${DESIGN_NAME}.gds

###############################################################################
# End of file
###############################################################################
