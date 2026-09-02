####################################################################################
              #########################################################
                     #### Section 1 : Clock Definition ####
              #########################################################
####################################################################################
# 1. Master Clock Definitions 
# 2. Clock Latencies
# 3. Clock Uncertainties
# 4. Clock Transitions
# 5. Propagated Clock  ( added, see note below)
# 6. Clock Network dont_touch

##### any command related to clock use [ get_clocks ]

#  The following variables are PROJECT-WIDE and must already be defined
#  before this file runs:
#*   clk_sys_name           -- name of the master clock                
#*   clk_period             -- clock period in ns                      
#*   clk_latency            -- clock source/network latency in ns
#*   clk_rise               -- clock rise transition time
#*   clk_fall               -- clock fall transition time
#*   clk_hold_uncertainty   -- clock uncertainty applied for hold
#*   clk_setup_uncertainty  -- clock uncertainty applied for setup
#*   clk_port               -- design's clock port (e.g. CLK)

####################################################################################
# 1. Master Clock Definition
####################################################################################
create_clock -name $clk_sys_name \
              -period $clk_period \
              -waveform [list 0 [expr {$clk_period / 2.0}]] \
              [get_ports $clk_port]

####################################################################################
# 2. Clock Latency
####################################################################################
set_clock_latency $clk_latency [get_clocks $clk_sys_name]

####################################################################################
# 3. Clock Uncertainty
####################################################################################
set_clock_uncertainty -setup $clk_setup_uncertainty [get_clocks $clk_sys_name]
set_clock_uncertainty -hold  $clk_hold_uncertainty [get_clocks $clk_sys_name]

####################################################################################
# 4. Clock Transition
####################################################################################
set_clock_transition -rise $clk_rise [get_clocks $clk_sys_name]
set_clock_transition -fall $clk_fall [get_clocks $clk_sys_name]

####################################################################################
# 5. Clock Network dont_touch
####################################################################################
#  Prevents the tool from inserting/ modifying buffers on the clock network during optimization.
#  clock tree is built later during CTS.

set_dont_touch_network [get_clocks $clk_sys_name]
