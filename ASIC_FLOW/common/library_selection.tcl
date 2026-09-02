###############################################################################
#
# Script Name : library_selection.tcl
#
# Purpose     : Project-level library / corner SELECTION layer. It sits between
#               the standalone Library Setup framework
#               (lib_setup/Master_lib_setup.tcl) and every flow stage
#               (SYN / CONS / PnR / STA / FM / Signoff).
#
#               The Library Setup owns the PDK data: every path, library name,
#               operating-condition name, NDM / LEF / GDS / TLU+ / tech file and
#               special-cell list. THIS file only SELECTS which corner each
#               family uses and exports the SELECTED_* variables that the flow
#               scripts consume. Flow scripts never touch the raw Library Setup
#               values directly - they use SELECTED_* only.
#
# Hierarchy   : Library Setup -> library_selection.tcl -> SYN/CONS/PnR/STA/FM/Signoff
#
# Flow Stage  : Common (all stages)
#
# Inputs      : Library Setup framework (sourced below if not already loaded)
#
# Outputs     : SELECTED_* variables consumed by every flow stage.
#
# Dependencies: lib_setup/Master_lib_setup.tcl (via $LIB_SETUP_DIR)
#
#
###############################################################################

# ###########################################################################
# 0. Library Setup bootstrap (idempotent)
# ###########################################################################
# common/variables.tcl already sources Master_lib_setup.tcl before this file.
# For standalone use, load it here (guarded so it is only sourced once).
# $LIB_SETUP_DIR must be defined (it is, in common/variables.tcl).

if {![info exists DESIGN_REF_PATH]} {
    source "${LIB_SETUP_DIR}/Master_lib_setup.tcl"
}

# ###########################################################################
# 1. Standard-cell corner (STD)
# ###########################################################################
# Primary standard-cell corner used for synthesis target / link, driving cells
# and wire-load lookup. Uncomment one option (all 27 corners are valid):

set STD_CORNER "tt1p05v25c"    

if {![info exists STD_CORNER]} { set STD_CORNER "tt1p05v25c" }
if {[lsearch -exact $STD_CORNERS $STD_CORNER] < 0} {
    error "library_selection.tcl: unknown STD_CORNER '$STD_CORNER'. Pick one of: $STD_CORNERS"
}

set SELECTED_STD_DB   [set STD_${STD_CORNER}_DB]
set SELECTED_STD_LIB  [set STD_${STD_CORNER}_LIB]
set SELECTED_STD_NAME [set STD_${STD_CORNER}_NAME]
set SELECTED_STD_COND [set STD_${STD_CORNER}_COND]

# ###########################################################################
# 2. SRAM corner
# ###########################################################################
# Uncomment one option (all 9 corners are valid): 

set SRAM_CORNER "tt1p05v25c"      

if {![info exists SRAM_CORNER]} { set SRAM_CORNER "tt1p05v25c" }
if {[lsearch -exact $SRAM_CORNERS $SRAM_CORNER] < 0} {
    error "library_selection.tcl: unknown SRAM_CORNER '$SRAM_CORNER'. Pick one of: $SRAM_CORNERS"
}

set SELECTED_SRAM_DB   [set SRAM_${SRAM_CORNER}_DB]
set SELECTED_SRAM_LIB  [set SRAM_${SRAM_CORNER}_LIB]
set SELECTED_SRAM_NAME [set SRAM_${SRAM_CORNER}_NAME]
set SELECTED_SRAM_COND [set SRAM_${SRAM_CORNER}_COND]

# ###########################################################################
# 3. IO corner
# ###########################################################################
# Uncomment one option (all 9 corners are valid): 

set IO_CORNER "tt1p05v25c_2p5v"    

if {![info exists IO_CORNER]} { set IO_CORNER "tt1p05v25c_2p5v" }
if {[lsearch -exact $IO_CORNERS $IO_CORNER] < 0} {
    error "library_selection.tcl: unknown IO_CORNER '$IO_CORNER'. Pick one of: $IO_CORNERS"
}

set SELECTED_IO_DB   [set IO_${IO_CORNER}_DB]
set SELECTED_IO_LIB  [set IO_${IO_CORNER}_LIB]
set SELECTED_IO_NAME [set IO_${IO_CORNER}_NAME]
set SELECTED_IO_COND [set IO_${IO_CORNER}_COND]

# ###########################################################################
# 4. PLL corner
# ###########################################################################
# Uncomment one option (all 9 corners are valid): 

set PLL_CORNER "tt1p05v25c_2p5v"   


if {![info exists PLL_CORNER]} { set PLL_CORNER "tt1p05v25c_2p5v" }
if {[lsearch -exact $PLL_CORNERS $PLL_CORNER] < 0} {
    error "library_selection.tcl: unknown PLL_CORNER '$PLL_CORNER'. Pick one of: $PLL_CORNERS"
}

set SELECTED_PLL_DB   [set PLL_${PLL_CORNER}_DB]
set SELECTED_PLL_LIB  [set PLL_${PLL_CORNER}_LIB]
set SELECTED_PLL_NAME [set PLL_${PLL_CORNER}_NAME]
set SELECTED_PLL_COND [set PLL_${PLL_CORNER}_COND]

# ###########################################################################
# 5. Min / Max operating-condition corners (STD, hold / setup analysis)
# ###########################################################################
# Best-case (fast) corner used for MIN / hold analysis; 
# worst-case (slow) corner used for MAX / setup analysis. 
# Any STD corner listed in section 1 is valid. 

if {![info exists STD_CORNER_MIN]} { set STD_CORNER_MIN "ff1p16vn40c" }
if {![info exists STD_CORNER_MAX]} { set STD_CORNER_MAX "ss0p95v125c" }
if {[lsearch -exact $STD_CORNERS $STD_CORNER_MIN] < 0} {
    error "library_selection.tcl: unknown STD_CORNER_MIN '$STD_CORNER_MIN'. Pick one of: $STD_CORNERS"
}
if {[lsearch -exact $STD_CORNERS $STD_CORNER_MAX] < 0} {
    error "library_selection.tcl: unknown STD_CORNER_MAX '$STD_CORNER_MAX'. Pick one of: $STD_CORNERS"
}

set SELECTED_STD_MIN_DB   [set STD_${STD_CORNER_MIN}_DB]
set SELECTED_STD_MIN_NAME [set STD_${STD_CORNER_MIN}_NAME]
set SELECTED_STD_MIN_COND [set STD_${STD_CORNER_MIN}_COND]
set SELECTED_STD_MAX_DB   [set STD_${STD_CORNER_MAX}_DB]
set SELECTED_STD_MAX_NAME [set STD_${STD_CORNER_MAX}_NAME]
set SELECTED_STD_MAX_COND [set STD_${STD_CORNER_MAX}_COND]

# ###########################################################################
# 6. RC corner (TLU+ extraction models)
# ###########################################################################
# The SAED32 PDK ships ONLY the Cmax (setup / max-delay) and Cmin (hold /
# min-delay) TLU+ pair. No "typical" model exists, so the pair is fixed.
#   set RC_CORNER "Cmax_Cmin"          <- only option (both models)

if {![info exists RC_CORNER]} { set RC_CORNER "Cmax_Cmin" }

set SELECTED_TLUP_MAX_FILE   $Tlup_max_file
set SELECTED_TLUP_MIN_FILE   $Tlup_min_file
set SELECTED_RC_MAP_FILE     $Map_file
set SELECTED_RC_MODEL_FILES  $RC_MODEL_FILES

# ###########################################################################
# 7. Technology files (corner-independent)
# ###########################################################################

set SELECTED_TECH_FILE   $Tech_file

set SELECTED_CLF_FILE    $Clf_file

# ###########################################################################
# 8. NDM reference libraries (physical, corner-independent)
# ###########################################################################

set SELECTED_STD_NDM                $STD_NDM
set SELECTED_SRAM_NDM               $SRAM_NDM
set SELECTED_IO_NDM                 $IO_NDM
set SELECTED_PLL_NDM                $PLL_NDM
set SELECTED_PHYSICAL_ONLY_NDM      $STD_PHYSICAL_ONLY_NDM
set SELECTED_PHYSICAL_REFERENCE_NDM $PHYSICAL_REFERENCE_NDM
set SELECTED_NDM_REFERENCE_LIBS     $NDM_REFERENCE_LIBS

# ###########################################################################
# 9. LEF / GDS files (corner-independent)
# ###########################################################################

set SELECTED_STD_LEF       $STD_LEF
set SELECTED_SRAM_LEF      $SRAM_LEF
set SELECTED_IO_LEF        $IO_LEF
set SELECTED_PLL_LEF       $PLL_LEF
set SELECTED_LEF_FILE_LIST $LEF_FILE_LIST

set SELECTED_STD_GDS       $Std_cell_gds
set SELECTED_GDS_MAP_FILE  $Gds_map_file
set SELECTED_GDS_FILE_LIST $GDS_FILE_LIST

# ###########################################################################
# 10. Special-cell lists (PnR / synthesis helpers, corner-independent)
# ###########################################################################

set SELECTED_STD_FILLER_CELLS $STD_FILLER_CELLS
set SELECTED_TAP_CELLS        $TAP_CELLS
set SELECTED_ANTENNA_CELLS    $ANTENNA_CELLS

# ###########################################################################
# 11. Link / target libraries and search path (composed from the selections)
# ###########################################################################
# With the default TT corners these equal the Library Setup values
# (TARGET_LIBRARY_FILES / LINK_LIBRARY_FILES / ADDITIONAL_SEARCH_PATH). When a
# different corner is selected, link / target follow it automatically - no path
# is re-written here.

set SELECTED_TARGET_LIBRARY_FILES    [list $SELECTED_STD_DB]
set SELECTED_LINK_LIBRARY_FILES      [list * $SELECTED_STD_DB $SELECTED_SRAM_DB $SELECTED_IO_DB $SELECTED_PLL_DB $SELECTED_STD_MIN_DB $SELECTED_STD_MAX_DB]
set SELECTED_ADDITIONAL_SEARCH_PATH  $ADDITIONAL_SEARCH_PATH

###############################################################################
# End of file
###############################################################################
