###############################################################################
#
# Script Name : data_setup.tcl
#
# Purpose     : Step-1 core work: create the NDM library from the technology
#               file and reference library, import the netlist, read
#               constraints and save the first checkpoint.
#
# Flow Stage  : PnR - Step 1 - Data Setup
#
# Inputs      : $SELECTED_TECH_FILE, $SELECTED_STD_NDM, $SELECTED_TLUP_MAX_FILE,
#               $SELECTED_TLUP_MIN_FILE, $SELECTED_RC_MAP_FILE (from
#               library_selection.tcl), $Core_compile, $Constraints_file
#
# Outputs     : ${DESIGN_NAME}_1_data_setup checkpoint
#
# Dependencies: common/design_setup.tcl, common/common_procedures.tcl,
#               ./save_restore.tcl
#
###############################################################################

# ###########################################################################
# 1. Create the design library (NDM)
# ###########################################################################
# The NDM library is the ICC2 database that holds every block we save.
# -technology : process technology file (layers, rules, colors)
# -ref_libs   : reference (physical) libraries, e.g. std cells and SRAM frames
#
# The library is created from scratch every run ('sh rm -fr' first), so the
# flow is fully re-runnable.

file delete -force $ARCH_TOP_NDM

create_lib $ARCH_TOP_NDM -technology $SELECTED_TECH_FILE -ref_libs $SELECTED_STD_NDM

###########################################################################
# 2. Read parasitic technology (TLU+)
###########################################################################
# TLU+ files hold the metal/RC models used for in-design parasitic estimates.
# Max and min corners are read together and later assigned per corner in
# common/mcmm.tcl.

read_parasitic_tech -tlup "$SELECTED_TLUP_MAX_FILE $SELECTED_TLUP_MIN_FILE" \
                    -layermap $SELECTED_RC_MAP_FILE

# ###########################################################################
# 3. Import the gate-level netlist
# ###########################################################################
# $SYN_NETLIST is the DC-synthesized netlist (see syn/save_outputs.tcl).

read_verilog "${ROOT_DIR}/syn/output/${DESIGN_NAME}_netlist.v"

# Select the top module and apply the SDC.

current_design $DESIGN_NAME

source $Constraints_file_post_syn

###########################################################################
###########################################################################
###########################################################################
# 4.Layout Choices
###########################################################################
###########################################################################

# Power net names (per-DI/PDK convention)
set POWER_NET             "VDD"
set GROUND_NET            "VSS"
set POWER_PORT            "VDD"
set GROUND_PORT           "VSS"

# Preferred routing direction of the top PnR metal layers
set pns_hlayer            "M7"     ;# top horizontal power mesh layer
set pns_vlayer            "M6"     ;# top vertical power mesh layer
set pns_mid_layer         "M5"     ;# middle horizontal power mesh layer

# Routing layer budget used by signal routing
set route_min_layer       "M2"
set route_max_layer       "M5"

# ###########################################################################
# 5. MCMM / STA naming
# ###########################################################################

# Corner, mode and scenario names used across mcmm.tcl and PT flows.
# Adjust to the actual analysis views of your PDK.
set MCMM_CORNERS          {slow fast}
set MCMM_CORNER_SLOW      "slow"
set MCMM_CORNER_FAST      "fast"
set MCMM_MODE_FUNC        "func"
set MCMM_SCENARIO_SLOW    "func_slow"
set MCMM_SCENARIO_FAST    "func_fast"

# ###########################################################################
# 6. Save the first checkpoint
# common procedure
# ###########################################################################
save_lb_to_checkpoint $NEW_CHECKPOINT


###############################################################################
# End of file
###############################################################################
