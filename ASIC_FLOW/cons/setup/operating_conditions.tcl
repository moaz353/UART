####################################################################################
            #########################################################
                  #### Section 6 : Operating Condition ####
            #########################################################
####################################################################################
# Define the library for MAX (setup) analysis -- worst-case (slow) corner
# Define the library for MIN (hold) analysis  -- best-case (fast) corner

#  Project-wide variables expected from Common (from library_selection.tcl):
#*   lib_min  -- best-case (fast) corner LIBRARY name, used for MIN (hold) analysis
#*   lib_max  -- worst-case (slow) corner LIBRARY name, used for MAX (setup) analysis
#*   lib_min_cond -- MIN operating-condition NAME inside $lib_min
#*   lib_max_cond -- MAX operating-condition NAME inside $lib_max
#
#  NOTE: the library name and the operating-condition name are DIFFERENT.
#  Verified in the installed SAED32 libs: the condition inside
#  saed32rvt_ss0p95v125c.db is "ss0p95v125c" (corner token), NOT the library
#  name. -min_library/-max_library take the LIBRARY name, -min/-max take the
#  CONDITION name.

set_operating_condition -min_library $lib_min -min $lib_min_cond -max_library $lib_max -max $lib_max_cond
