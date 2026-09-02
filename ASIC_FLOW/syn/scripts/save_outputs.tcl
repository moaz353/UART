###############################################################################
#
# Script Name : save_outputs.tcl
#
# Purpose     : Write all synthesis outputs: gate-level netlist, DDC, SDC and
#               SDF.
#
# Outputs     : ${SYN_NETLIST}, ${SYN_DDC}, ${SYN_SDC}, ${SYN_SDF}
#
# Dependencies: syn/scripts/variables.tcl
#
###############################################################################

banner "Writing outputs"

# ###########################################################################
# 1. Rename nets/cells to Verilog-friendly names
# ###########################################################################
# Avoids illegal characters (e.g. '[', '/') in the emitted netlist.
change_names -rules verilog

# ###########################################################################
# 2. Gate-level netlist
# ###########################################################################
# -pg keeps power/ground nets in the netlist so the PnR step 1 can map them.
write_file -format verilog -hierarchy -output $SYN_NETLIST

# ###########################################################################
# 3. DDC (binary design container for the next DC / ICC2 session)
# ###########################################################################
write_file -format ddc -hierarchy -output $SYN_DDC

# ###########################################################################
# 4. SDC (constraints export for ICC2 / PT)
# ###########################################################################
write_sdc -nosplit $SYN_SDC

# ###########################################################################
# 5. SDF (simulation back-annotation, optional)
# ###########################################################################
write_sdf $SYN_SDF

###############################################################################
# End of file
###############################################################################
