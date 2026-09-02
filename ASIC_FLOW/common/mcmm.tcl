###############################################################################
#
# Script Name : mcmm.tcl
#
# Purpose     : Multi-Corner Multi-Mode (MCMM) setup for ICC2: create corners,
#               modes, scenarios, associate parasitic TLU+ files and read the
#               constraints into each scenario.
#
# Dependencies: common/variables.tcl, common/design_setup.tcl
#
###############################################################################

banner "MCMM setup"

# ###########################################################################
# 1. Clean any pre-existing MCMM data
# ###########################################################################
# Always start from a clean slate so the script is re-runnable on a block
# that already contains corners/scenarios (e.g. after an interrupted run).

remove_corners -all
remove_modes   -all
remove_scenarios -all

# ###########################################################################
# 2. Create corners
# ###########################################################################
# A corner bundles a library set, operating condition and RC settings.

create_corner $MCMM_CORNER_SLOW
create_corner $MCMM_CORNER_FAST

# ###########################################################################
# 3. Read parasitic technology files (TLU+) per corner
# ###########################################################################
# read_parasitic_tech can be called with -name to tag the extraction spec;
#  "tlup_max"/"tlup_min".

read_parasitic_tech \
    -tlup $SELECTED_TLUP_MAX_FILE \
    -layermap $SELECTED_RC_MAP_FILE \
    -name tlup_max

read_parasitic_tech \
    -tlup $SELECTED_TLUP_MIN_FILE \
    -layermap $SELECTED_RC_MAP_FILE \
    -name tlup_min

# ###########################################################################
# 4. Assign extraction specs to the corners
# ###########################################################################
# The fast corner (hold / min-delay analysis) uses the minimum RC (Cmin)
# for both early and late extraction; the slow corner uses the maximum RC.

set_parasitics_parameters \
    -early_spec tlup_min \
    -late_spec  tlup_min \
    -corners    ${MCMM_CORNER_FAST}

set_parasitics_parameters \
    -early_spec tlup_max \
    -late_spec  tlup_max \
    -corners    ${MCMM_CORNER_SLOW}

# ###########################################################################
# 5. Create the functional mode and the two scenarios
# ###########################################################################
# A mode groups SDC modes (functional / test / scan). A scenario is a
# (mode, corner) pair that the optimizer analyzes.

create_mode $MCMM_MODE_FUNC
current_mode $MCMM_MODE_FUNC

create_scenario -mode $MCMM_MODE_FUNC -corner $MCMM_CORNER_FAST -name $MCMM_SCENARIO_FAST
create_scenario -mode $MCMM_MODE_FUNC -corner $MCMM_CORNER_SLOW -name $MCMM_SCENARIO_SLOW

# ###########################################################################
# 6. Read the constraints into each scenario
# ###########################################################################
# Constraints are read per scenario so that timing arcs are annotated for all
# views before any optimization or report is run.

current_scenario $MCMM_SCENARIO_FAST
read_sdc $Constraints_file_post_syn

current_scenario $MCMM_SCENARIO_SLOW
read_sdc $Constraints_file_post_syn

banner "MCMM setup completed"

###############################################################################
# End of file
###############################################################################
