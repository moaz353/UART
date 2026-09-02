###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Step-7 final QoR, timing, power, cell-usage and design reports.
#
# Flow Stage  : PnR - Step 7 - Finishing
#
# Dependencies: common/common_procedures.tcl, ./variables.tcl
#
###############################################################################

# ###########################################################################
# 1. Overall QoR summary
# ###########################################################################
# Provides a high-level summary of the final design quality, including
# timing and area-related QoR information.
create_qor_snapshot_and_report ${STAGE_REPORT_DIR} "final"

# ###########################################################################
# 2. Final max / min timing
# ###########################################################################
report_timing_max_min ${STAGE_REPORT_DIR} "final"

# ###########################################################################
# 3. Crosstalk delta report
# ###########################################################################
report_timing -crosstalk_delta > ${STAGE_REPORT_DIR}/crosstalk_delta.tim


# ###########################################################################
# 4. Power report
# ###########################################################################
report_power > ${STAGE_REPORT_DIR}/${DESIGN_NAME}.final_power.rpt

# ###########################################################################
# 5. Cell usage report
# ###########################################################################
# Reports the cells used in the final design.
report_cell > ${STAGE_REPORT_DIR}/${DESIGN_NAME}.final_cell_usage.rpt


# ###########################################################################
# 6. Reference / cell-type usage
# ###########################################################################
# Reports the number and usage of different cell references in the design.
report_reference > ${STAGE_REPORT_DIR}/${DESIGN_NAME}.final_reference_usage.rpt

# ###########################################################################
# 7. Final design summary
# ###########################################################################
report_design -all > ${STAGE_REPORT_DIR}/${DESIGN_NAME}_PR_summary.rpt

###############################################################################
# End of file
###############################################################################
