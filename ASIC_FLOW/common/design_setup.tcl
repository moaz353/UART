###############################################################################
#
# Script Name : design_setup.tcl
#
# Purpose     : Tool-agnostic library and environment setup. Kept separate
#               from variables.tcl so that a project can override library
#               lists here without touching the variable definitions.
#
# Flow Stage  : Common (Design Compiler / ICC2 / Formality)
#
# Inputs      : Variables from common/variables.tcl, including the Library
#               Setup framework values and the project SELECTION layer values
#               (SELECTED_ADDITIONAL_SEARCH_PATH, SELECTED_LINK_LIBRARY_FILES,
#               SELECTED_TARGET_LIBRARY_FILES).
#
# Outputs     : link_library / target_library / search_path and related
#               tool settings.
#
# Dependencies: common/variables.tcl
#
###############################################################################

# ###########################################################################
# 1. Search path
# ###########################################################################
# Allow DC/ICC2 to resolve library and RTL files without absolute paths.
# SELECTED_ADDITIONAL_SEARCH_PATH comes from the project selection layer 
# (analias of the Library Setup ADDITIONAL_SEARCH_PATH).

set search_path ". ${search_path} ${SELECTED_ADDITIONAL_SEARCH_PATH} ${VERILOG_DIR}"

# ###########################################################################
# 2. Link / Target libraries
# ###########################################################################
# - link_library  : libraries used to resolve cells during linking.
#                 
# - target_library: cells the tool may map to (synthesis / optimization).

set link_library          "$SELECTED_LINK_LIBRARY_FILES"
set target_library        "$SELECTED_TARGET_LIBRARY_FILES" 

# ###########################################################################
# 3. NDM design library
# ###########################################################################
# Created in step 1, reused by every later PnR stage.

set ARCH_TOP_NDM "${LIBRARY_DIR}/${DESIGN_NAME}.ndm"

###############################################################################
# End of file
###############################################################################
