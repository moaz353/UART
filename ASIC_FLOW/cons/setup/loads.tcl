####################################################################################
              #########################################################
                     #### Section 5 : Output load ####
              #########################################################
####################################################################################
# applies a blanket load to all outputs

#  Project-wide variable expected from Common:
#*   output_load_value  -- capacitive load value applied to primary outputs (in library units)

set_load $output_load_value [all_outputs]
