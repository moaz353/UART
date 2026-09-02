###########################################################################################
####################################* Common_Const____#####################################
#
#  master.tcl -- Top-level entry point of the Constraints Framework.
#  This script  SOURCES the setup/ and optional/ files in the correct, dependency-safe order.
#
##########################################################################################

if {![info exists CONSTRAINTS_DIR]} {
    set CONSTRAINTS_DIR [file dirname [info script]]
}

puts " \[CONSTRAINTS_FRAMEWORK\] Loading constraints from $CONSTRAINTS_DIR"

####################################################################################
            #########################################################
                #### Section 0 : Framework Variables ####
            #########################################################
####################################################################################
#  variables.tcl holds ONLY variables that belong exclusively to this
#  Constraints framework (enable/disable flags, IO delay factor, etc).
#  Project-wide variables (clk_sys_name, clk_period, library names, ...) are
#  expected to already exist, sourced earlier from the project's Common folder.
if {[file exists $CONSTRAINTS_DIR/variables.tcl]} {
    source $CONSTRAINTS_DIR/variables.tcl
}

####################################################################################
            #########################################################
                #### Section 1 : Mandatory Setup (setup/) ####
            #########################################################
####################################################################################
#  These files are required for almost every design. 

source $CONSTRAINTS_DIR/setup/clocks.tcl
source $CONSTRAINTS_DIR/setup/io_constraints.tcl
source $CONSTRAINTS_DIR/setup/driving_cells.tcl
source $CONSTRAINTS_DIR/setup/loads.tcl
source $CONSTRAINTS_DIR/setup/operating_conditions.tcl
source $CONSTRAINTS_DIR/setup/design_rules.tcl

# ####################################################################################
#             #########################################################
#                 #### Section 2 : Optional Modules (optional/) ####
#             #########################################################
# ####################################################################################
# #  Each optional module is guarded by an ENABLE_* flag (default 0, defined in
# #  variables.tcl and overridable per-project BEFORE sourcing master.tcl).
# #  This keeps master.tcl clean and lets each project opt in only to what it needs.

if {$ENABLE_GENERATED_CLOCKS} { source $CONSTRAINTS_DIR/optional/generated_clocks.tcl }
if {$ENABLE_CLOCK_GROUPS}     { source $CONSTRAINTS_DIR/optional/clock_groups.tcl }
if {$ENABLE_CASE_ANALYSIS}    { source $CONSTRAINTS_DIR/optional/case_analysis.tcl }
if {$ENABLE_FALSE_PATHS}      { source $CONSTRAINTS_DIR/optional/false_paths.tcl }
if {$ENABLE_MULTICYCLE_PATHS} { source $CONSTRAINTS_DIR/optional/multicycle_paths.tcl }
if {$ENABLE_MIN_MAX_DELAY}    { source $CONSTRAINTS_DIR/optional/min_max_delay.tcl }
if {$ENABLE_DISABLE_TIMING}   { source $CONSTRAINTS_DIR/optional/disable_timing.tcl }
if {$ENABLE_DONT_TOUCH}       { source $CONSTRAINTS_DIR/optional/dont_touch.tcl }
if {$ENABLE_WIRELOAD_MODEL}   { source $CONSTRAINTS_DIR/optional/wireload_model.tcl }
if {$ENABLE_AREA_CONSTRAINTS} { source $CONSTRAINTS_DIR/optional/area_constraints.tcl }
if {$ENABLE_POWER_CONSTRAINTS} { source $CONSTRAINTS_DIR/optional/power_constraints.tcl }
if {$ENABLE_ADVANCED}         { source $CONSTRAINTS_DIR/optional/advanced_constraints.tcl }

puts " \[CONSTRAINTS_FRAMEWORK\] Done."
