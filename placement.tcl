echo "--- Running Global & Detailed Placement ---"

openroad -no_init -log $RESULTS_DIR/global_placement.log << EOF
# Read LEF files (PDK technology and standard cells physical info)
read_lef $PLATFORM_DIR/lef/NangateOpenCellLibrary.lef
read_lef $PLATFORM_DIR/tech/FreePDK45.tech.lef

# Read the floorplanned DEF file (contains the design with the floorplan)
read_def $RESULTS_DIR/mips_floorplanned.def

# Read the SDC for timing driven placement
read_sdc $DESIGN_DIR/mips.sdc

# Read the Liberty file for timing information of standard cells
read_liberty $PLATFORM_DIR/libs.ref/nangate45/lib/NangateOpenCellLibrary.lib

# Global placement command
global_placement

# Detailed placement command
detailed_placement

# Write the design to a DEF file
write_def $RESULTS_DIR/mips_global_placed.def

# Save a snapshot
save_image $RESULTS_DIR/mips_global_placed.png
EOF

echo "Placement complete. DEF generated: $RESULTS_DIR/mips_global_placed.def"
