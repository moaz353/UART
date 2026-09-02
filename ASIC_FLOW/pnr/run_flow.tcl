# ============================================================================
# Main PnR Flow
# ============================================================================
# Executes all PnR stages sequentially.
# To run the flow step-by-step, comment out the stages that should be skipped
# and leave only the desired step(s) uncommented.
# ============================================================================

# Step 1: Data Setup
source ./step_1_data_setup/scripts/master.tcl

# Step 2: Floorplanning
source ./step_2_floorplanning/scripts/master.tcl

# Step 3: Power Planning
source ./step_3_powerplanning/scripts/master.tcl

# Step 4: Placement
source ./step_4_placement/scripts/master.tcl

# Step 5: Clock Tree Synthesis (CTS)
source ./step_5_cts/scripts/master.tcl

# Step 6: Routing
source ./step_6_routing/scripts/master.tcl

# Step 7: Finishing
source ./step_7_finishing/scripts/master.tcl