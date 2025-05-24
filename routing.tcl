echo "--- Running Global & Detailed Routing ---"

openroad -no_init -log $RESULTS_DIR/global_routing.log << EOF
# Read LEF files
read_lef $PLATFORM_DIR/lef/NangateOpenCellLibrary.lef
read_lef $PLATFORM_DIR/tech/FreePDK45.tech.lef

# Read the CTS DEF
read_def $RESULTS_DIR/mips_cts.def

# Read the SDC
read_sdc $DESIGN_DIR/mips.sdc

# Read the Liberty file
read_liberty $PLATFORM_DIR/libs.ref/nangate45/lib/NangateOpenCellLibrary.lib

# Global routing command
global_route

# Detailed routing command
detailed_route

# Write the design to a DEF file
write_def $RESULTS_DIR/mips_global_routed.def

# Save a snapshot
save_image $RESULTS_DIR/mips_global_routed.png
EOF

echo "Global routing complete. DEF generated: $RESULTS_DIR/mips_global_routed.def"
