###############################################################################
#
# Script Name : fm_verify.tcl
#
# Purpose     : Formal verification.
#
#
# Inputs      : $FM_RTL_FILES, $FM_NETLIST, $FM_LIBS, $FM_SVF
#
###############################################################################

puts "Formality setup and verification"

# ###########################################################################
# 1. Tool settings
# ###########################################################################
# auto setup lets FM derive library/constraint handling automatically.
set synopsys_auto_setup true

# The SVF guides verification through the synthesis transformations.
set_svf $FM_SVF

# ###########################################################################
# 2. Reference container (golden RTL)
# ###########################################################################
# read_verilog -container Ref : load the RTL sources (one command per file
# or a list). read_db loads the technology libraries.
foreach rtl_file $FM_RTL_FILES {
    read_verilog -container Ref $rtl_file
}

read_db -container Ref $FM_LIBS

set_reference_design $DESIGN_NAME
set_top $DESIGN_NAME

# ###########################################################################
# 3. Implementation container (netlist)
# ###########################################################################
read_verilog -container Imp -netlist $FM_NETLIST

read_db -container Imp $FM_LIBS

set_implementation_design $DESIGN_NAME
set_top $DESIGN_NAME

# ###########################################################################
# 5. Match and verify
# ###########################################################################
match

set successful [verify]
if {!$successful} {
    puts "ERROR : verification failed, running diagnosis"
    diagnose
    analyze_points -failing
}

###############################################################################
# End of file
###############################################################################
