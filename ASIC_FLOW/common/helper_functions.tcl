###############################################################################
#
# Script Name : helper_functions.tcl
#
# Purpose     : Small, flow-independent Tcl utility procedures.
#
#
# ###########################################################################
# 1. Directory helpers
# ###########################################################################

# Create a directory if it does not exist yet.
#   Usage: ensure_directory $REPORT_DIR
proc ensure_directory {dir} {
    if {![file exists $dir]} {
        file mkdir $dir
        puts "Created directory : $dir"
    }
}

# ###########################################################################
# 2. Path checking
# ###########################################################################

# Warn (do not abort) if a file is missing. Returns 1 when present.
proc check_file_exists {path} {
    if {[file exists $path]} {
        return 1
    }
    puts "WARNING : file does not exist : $path"
    return 0
}

# Abort the flow if a required file is missing. Use for hard dependencies.
proc require_file {path} {
    if {![file exists $path]} {
        puts "ERROR : required file does not exist : $path"
        exit 1
    }
}

# ###########################################################################
# 3. List helpers
# ###########################################################################

# Prefix every element of a list with "*/" so it matches cells from any
# library/ hierarchy. Used for filler lists, CTS reference lists, etc.
proc prefix_list {items} {
    set result {}
    foreach item $items {
        lappend result "*/${item}"
    }
    return $result
}

###############################################################################
# End of file
###############################################################################
