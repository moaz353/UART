####################################################################################
              #########################################################
                     #### Section 4 : Driving cells ####
              #########################################################
####################################################################################
# applies a blanket driving cell to all inputs (excluding the clock port)

#  Project-wide variables expected from Common:
#*   drive_lib   -- library containing the driving cell (e.g. corner ss_1p08v_125c)
#*   drive_cell  -- driving cell name (e.g. BUFX2M)
#*   drive_pin   -- output pin of the driving cell (e.g. Y)
#*   clk_port    -- clk physical port (from clk_variables)


set_driving_cell -library ${drive_lib} -lib_cell ${drive_cell} \
              -pin ${drive_pin} [remove_from_collection [all_inputs] [get_ports ${clk_port}]]

