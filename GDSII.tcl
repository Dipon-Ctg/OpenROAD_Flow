echo "--- Generating GDSII ---"

openroad -no_init -log $RESULTS_DIR/gds.log << EOF
# Read LEF files
read_lef $PLATFORM_DIR/lef/NangateOpenCellLibrary.lef
read_lef $PLATFORM_DIR/tech/FreePDK45.tech.lef

# Read the detailed routed DEF
read_def $RESULTS_DIR/mips_detailed_routed.def

# Load the technology file that contains the GDS layer mapping
# For Nangate45/FreePDK45, this is usually provided as part of the platform.
# The OpenROAD flow scripts typically use a specific tech file like 'OpenROAD_Nangate45.tech'
# that defines this mapping for the write_gds command.
read_db $PLATFORM_DIR/tech/OpenROAD_Nangate45.tech

# Write GDSII
write_gds $RESULTS_DIR/mips.gds

EOF

echo "GDSII generation complete. File: $RESULTS_DIR/mips.gds"
