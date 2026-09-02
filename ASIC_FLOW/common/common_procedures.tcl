###############################################################################
#
# Script Name : common_procedures.tcl
#
# Purpose     : Shared Tcl procedures that implement the recurring patterns of
#               the flow: open/save/close blocks, PG connection, QoR
#               snapshots, standard reports and final output writing.
#               Extracted from repeated code in the reference lab scripts.
#
#
# Outputs     : None (procedures side-effect on the open design)
#
# Dependencies: common/variables.tcl, common/helper_functions.tcl
#
#
###############################################################################

# ###########################################################################
# 1. Console puts
# ###########################################################################

# Print a clearly visible stage banner to the log so runs are easy to grep.
proc banner {text} {
    puts "###############################################################################"
    puts "### ${text}"
    puts "###############################################################################"
}

# ###########################################################################
# 2. Open / Save / Close (block-level) helpers
# ###########################################################################
#? lb ----> library and block

proc open_lb_from_checkpoint {prev_checkpoint temp_block} {
    global ARCH_TOP_NDM 
    banner "Open library and previous checkpoint"

    open_lib $ARCH_TOP_NDM
    copy_block -from_block $prev_checkpoint -to $temp_block
    open_block $temp_block

    report_lib $ARCH_TOP_NDM
}

# Save the current working block under a new named checkpoint.
proc save_lb_to_checkpoint {checkpoint} {
    banner "Save block : ${checkpoint}"
    save_block -as $checkpoint
    save_lib
}

# Close the working block and the library.
proc close_stage {} {
    banner "Close library"
    close_block
    close_lib
}

# ###########################################################################
# 3. Power / Ground net setup
# ###########################################################################
# Set net types and connect the PG pins of every physical cell to the
# power/ground nets.
#
proc setup_pg_nets {power ground} {
    banner "Setup power and ground nets"

    create_net -power  $power
    create_net -ground $ground

    set_attribute -objects [get_nets $power] -name net_type -value power
    set_attribute -objects [get_nets $ground] -name net_type -value ground

    connect_pg_net -net $power  [get_pins -physical_context */${power}]
    connect_pg_net -net $ground [get_pins -physical_context */${ground}]

    check_mv_design
}

# ###########################################################################
# 4. QoR snapshot + standard reports
# ###########################################################################
# Create a QoR snapshot and standard reports for the specified implementation
# stage. Reports are stored under STAGE_REPORT_DIR, with QoR-related reports
# in the qor_snapshot subdirectory.
#
proc create_qor_snapshot_and_report {STAGE_REPORT_DIR stage_name} {
    set_app_option -name time.snapshot_storage_location -value "${STAGE_REPORT_DIR}/qor_snapshot"

    create_qor_snapshot -name $stage_name -significant_digits 4

    report_qor_snapshot -name $stage_name        > ${STAGE_REPORT_DIR}/qor_snapshot/${stage_name}.qor_snapshot.rpt
    report_qor                          -nosplit > ${STAGE_REPORT_DIR}/qor_snapshot/${stage_name}.qor
    report_constraints -all_violators   -nosplit > ${STAGE_REPORT_DIR}/qor_snapshot/${stage_name}.con
    report_global_timing -sig 3         -nosplit > ${STAGE_REPORT_DIR}/qor_snapshot/${stage_name}.global.tim
}

# Max (setup) and min (hold) timing reports for the specified implementation
# stage. Reports are stored under STAGE_REPORT_DIR/timing.
#
proc report_timing_max_min {STAGE_REPORT_DIR stage_name} {
    report_timing -capacitance -transition_time -input_pins -nets \
                    -delay_type max -path full \
                    > ${STAGE_REPORT_DIR}/timing/${stage_name}.max.tim

    report_timing -capacitance -transition_time -input_pins -nets \
                    -delay_type min -path full \
                    > ${STAGE_REPORT_DIR}/timing/${stage_name}.min.tim
}

# ###########################################################################
# 6. Constraint / path-group setup
# ###########################################################################
# Group paths so timing reports are presented per endpoint category.
#   Usage: setup_path_groups
proc setup_path_groups {} {
    group_path -name INPUT  -from [all_inputs]
    group_path -name OUTPUT -to   [all_outputs]
    group_path -name COMBO  -from [all_inputs] -to [all_outputs]
}
###############################################################################
# End of file
###############################################################################
