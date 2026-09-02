###############################################################################
#
# Script Name : variables.tcl
#
# Purpose     : Step-5 specific variables: checkpoint names, CTS references,
#               clock rules and target skew.
#
# Flow Stage  : PnR - Step 5 - CTS
#
# Dependencies: common/variables.tcl
#
#############################################################################

set PNR_DIR               "${ROOT_DIR}/pnr"

# ###########################################################################
# 1. Checkpoint naming
# ###########################################################################
set PREV_CHECKPOINT "${DESIGN_NAME}_4_place_ends"
set TEMP_BLOCK      "temp_place_ends"
set NEW_CHECKPOINT  "${DESIGN_NAME}_5_clock_ends"

# ###########################################################################
# 2. Clock tree targets
# ###########################################################################
set TARGET_SKEW    0.1
set CLK_UNCERTAINTY 0.1

# Clocks to build. "all_clocks" is the default; set a per-clock list when the
# design has multiple domains with different targets:
set CTS_CLOCKS [all_clocks]

# ###########################################################################
# 3. CTS cell references (inverters / buffers)
# ###########################################################################
# CTS cells selected from the SAED32 RVT standard-cell library.

set CTS_REFERENCE_CELLS {
    INVX1_RVT  INVX2_RVT  INVX4_RVT  INVX8_RVT  INVX16_RVT  
    IBUFFX2_RVT NBUFFX2_RVT IBUFFX4_RVT NBUFFX4_RVT 
    IBUFFX8_RVT NBUFFX8_RVT IBUFFX16_RVT NBUFFX16_RVT  
}

# ###########################################################################
# 4. Clock routing rule (spacing for less coupling / crosstalk)
# ###########################################################################
set CLK_RULE_NAME         "CLK_SPACING"
set CLK_RULE_SPACINGS     {M2 0.3 M3 0.5 M4 0.7}
set CLK_RULE_MIN_LAYER    "M2"
set CLK_RULE_MAX_LAYER    "M4"

# ###########################################################################
# 5. Optimization naming
# ###########################################################################
set USER_INSTANCE_PREFIX "clock"

# ###########################################################################
# 6. Report location for this stage
# ###########################################################################
set STAGE_REPORT_DIR           "${PNR_DIR}/step_5_cts/reports"
set STAGE_OUTPUT_DIR           "${PNR_DIR}/step_5_cts/outputs"
set CLOCK_PRE_ROUTE_QOR_DIR    "${STAGE_REPORT_DIR}/qor_snapshot_clock_pre_route"
set CLOCK_PRE_ROUTE_TIMING_DIR "${CLOCK_PRE_ROUTE_QOR_DIR}/timing"

###############################################################################
# End of file
###############################################################################
