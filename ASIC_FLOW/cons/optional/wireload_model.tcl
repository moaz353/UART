####################################################################################
              #########################################################
                     #### Section 7 : Wireload Model ####
              #########################################################
####################################################################################
#  Enable via ENABLE_WIRELOAD_MODEL = 1. DESIGN COMPILER ONLY -- wireload
#  models estimate parasitics before physical placement exists.

# variables : 
#            - wire_load_model      ##__exp (tsmc13_wl30)
#            - wire_load_library    ##__exp (scmetro_tsmc_cl013g_rvt_ss_1p08v_125c)


set_wire_load_model -name ${wire_load_model} -library ${wire_load_library}
