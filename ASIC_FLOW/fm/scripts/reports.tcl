###############################################################################
#
# Script Name : reports.tcl
#
# Purpose     : Formality verification reports.
#
# Outputs     : passing/failing/aborted/unverified point reports
#
###############################################################################

report_passing_points    > ${FM_REPORT_DIR}/passing_points.rpt
report_failing_points    > ${FM_REPORT_DIR}/failing_points.rpt
report_aborted_points    > ${FM_REPORT_DIR}/aborted_points.rpt
report_unverified_points > ${FM_REPORT_DIR}/unverified_points.rpt

###############################################################################
# End of file
###############################################################################
