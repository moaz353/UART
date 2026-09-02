####################################################################################
# variables.tcl -- Constraints-Framework-ONLY variables
#
# This file contains project constraint variables used by the constraints framework.
#
# It holds:
#   1) Project-specific constraint parameters (clock, IO, design rules, loads, etc).
#   2) Generic knobs shared by multiple constraint setup files.
#   3) ENABLE_* feature flags that turn optional constraint modules on or off.
#
######################################################################################
######################################################################################
##################################!____Project_Constraints_Variables__################
######################################################################################
######################################################################################

######################################################################################*_______setup_____

##############____1_clock_variables__################################################# (clock.tcl)   

set  clk_sys_name         "sys_clk" ; #*____ name of the master clock __(logical name)    
set  clk_period             10   ;     #*____ clock period in ns
set  clk_latency            0    ;     #*____ clock source/network latency in ns
set  clk_rise               0.05 ;     #*____ clock rise transition time          
set  clk_fall               0.05 ;     #*____ clock fall transition time
set  clk_hold_uncertainty   0.1  ;     #*____ clock uncertainty applied for hold
set  clk_setup_uncertainty  0.1  ;     #*____ clock uncertainty applied for setup
set  clk_port              "clk" ;     #*____ design's clock port __(physical port in rtl) 

######################################################################################

##############____2_ Design_Rule_variables__########################################## (design_rules.tcl) 

set max_transition_value   0.5 ;    #*____ maximum allowed transition time for signals
set max_fanout_value       16  ;    #*____ maximum number of loads driven by a cell
set max_capacitance_value  0.5 ;    #*____ maximum allowed capacitance on a net

######################################################################################

##############____3_Driving cells_variables__######################################### (driving_cells.tcl)

set drive_lib     $SELECTED_STD_NAME ;     #*____ library containing the driving cell (selected STD corner)
set drive_cell    "IBUFFX2_RVT"      ;     #*____ cell used to model input driving strength
set drive_pin     "Y"                ;     #*____ output pin of the driving cell

######################################################################################

##############____4_input/output delay__############################################## (io_constraints.tcl)

#? Fraction of the clock period used for input/output delay when a design
#? does not provide explicit delay numbers.

set io_delay_factor   0.2

#####################################################################################

##############____5_Output_load_variables__########################################## (loads.tcl)

set output_load_value     0.02 ;  #*____ capacitance load applied to output ports

#####################################################################################

# ##############____6_Operating_Condition_variables__################################ (operating_condition.tcl)

set lib_min       $SELECTED_STD_MIN_NAME  ; #*____ min (hold) corner LIBRARY name (fast, default FF)
set lib_max       $SELECTED_STD_MAX_NAME  ; #*____ max (setup) corner LIBRARY name (slow, default SS)
set lib_min_cond  $SELECTED_STD_MIN_COND  ; #*____ min operating-condition NAME inside $lib_min (corner token)
set lib_max_cond  $SELECTED_STD_MAX_COND  ; #*____ max operating-condition NAME inside $lib_max (corner token)


####################################################################################
################################################################################################?_______optional_____

##############____2_Area_variables__################################################ (area_constraints.tcl)
set max_area_value   0  ;   #*____ maximum allowed design area target 

####################################################################################

##############____12_wireload_model_variables__##################################### (wireload_model.tcl)
set wire_load_model     "ForQA"             ;             #*____ wire load model used for delay estimation
set wire_load_library   $SELECTED_STD_NAME  ;  #*____ library containing the wire load model (selected STD corner)

####################################################################################
####################################################################################
###############################################################################################?___Modes 
            #########################################################
                #### Optional Module Enable Flags (default OFF) ####
            #########################################################
####################################################################################
# Every flag defaults to 0 (disabled). A project template should only
# set the ones it actually needs to 1.

if {![info exists ENABLE_GENERATED_CLOCKS]}  { set ENABLE_GENERATED_CLOCKS  0 } ;# design has internally generated/gated clocks
if {![info exists ENABLE_CLOCK_GROUPS]}      { set ENABLE_CLOCK_GROUPS      0 } ;# design has >1 clock domain (async/exclusive)
if {![info exists ENABLE_CASE_ANALYSIS]}     { set ENABLE_CASE_ANALYSIS     0 } ;# design has mode/test pins to fix at a constant
if {![info exists ENABLE_FALSE_PATHS]}       { set ENABLE_FALSE_PATHS       0 } ;# design has known-false timing paths
if {![info exists ENABLE_MULTICYCLE_PATHS]}  { set ENABLE_MULTICYCLE_PATHS  0 } ;# design has paths needing >1 cycle
if {![info exists ENABLE_MIN_MAX_DELAY]}     { set ENABLE_MIN_MAX_DELAY     0 } ;# design needs explicit set_max_delay/set_min_delay
if {![info exists ENABLE_DISABLE_TIMING]}    { set ENABLE_DISABLE_TIMING    0 } ;# design needs specific arcs disabled (e.g. scan)
if {![info exists ENABLE_DONT_TOUCH]}        { set ENABLE_DONT_TOUCH        0 } ;# design has cells/nets that must not be touched
if {![info exists ENABLE_WIRELOAD_MODEL]}    { set ENABLE_WIRELOAD_MODEL    1 } ;# legacy DC flows without a physical floorplan
if {![info exists ENABLE_AREA_CONSTRAINTS]}  { set ENABLE_AREA_CONSTRAINTS  1 } ;# design has an explicit max-area budget
if {![info exists ENABLE_POWER_CONSTRAINTS]} { set ENABLE_POWER_CONSTRAINTS 0 } ;# design has power budgets/UPF-driven flow
if {![info exists ENABLE_ADVANCED]}          { set ENABLE_ADVANCED          1 } ;# rarely-needed DC-specific netlist switches

################################################################################################################################___end