####################################################################################
          #########################################################
            #### Section 3 : set input/output delay on ports ####
          #########################################################
####################################################################################
# applies a blanket input delay to all inputs (excluding the clock port) 
# applies a blanket output delay to all outputs 

#  io_delay_factor comes from variables.tcl (constraints-only knob).
set input_delay  [expr {$io_delay_factor * $clk_period}]
set output_delay [expr {$io_delay_factor * $clk_period}]

set_input_delay  $input_delay  -clock $clk_sys_name [remove_from_collection [all_inputs]  [get_ports $clk_port]]

set_output_delay $output_delay -clock $clk_sys_name [all_outputs]
