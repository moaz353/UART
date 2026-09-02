####################################################################################
              #########################################################
                     #### Section 0 : DC Variables (Advanced) ####
              #########################################################
####################################################################################
#  Enable via ENABLE_ADVANCED = 1. DESIGN COMPILER ONLY. These are netlist-
#  shaping switches, not timing constraints -- they must be set BEFORE the
#  compile command.
# Prevent assign statements in the generated netlist (must be applied before compile command)

set verilogout_no_tri true
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs
