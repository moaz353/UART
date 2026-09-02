###############################################################################
#
# Script Name : compile_strategies.tcl
#
# Purpose     : Run the compile step. Supports the three optimization
#               strategies :
#                 timing -> timing-first compile
#                 area   -> area-first compile
#                 power  -> power-first compile
#
# Flow Stage  : Syn
#
#
# Dependencies: syn/scripts/variables.tcl
#
###############################################################################

banner "Mapping and optimization (strategy = ${COMPILE_STRATEGY})"

switch $COMPILE_STRATEGY {
    "area" {
        # Area-first: medium mapping, high area effort, no power effort.
        compile -map_effort medium -area_effort high -power_effort none
    }
    "power" {
        # Power-first: medium mapping, no area effort, high power effort.
        compile -map_effort medium -area_effort none -power_effort high
    }
    "timing" {
        # Timing-focused compilation with medium mapping effort.
        # For final timing closure an exact-map retarget pass is common:
        #   compile -exact_map -map_effort medium -area_effort medium -power_effort none

        compile -map_effort medium
    }
    default {
        puts "WARNING : unknown COMPILE_STRATEGY '${COMPILE_STRATEGY}', running timing-first"
        compile -map_effort medium
    }
}

check_design > ${SYN_REPORT_DIR}/${DESIGN_NAME}_check_design.rpt

###############################################################################
# End of file
###############################################################################
