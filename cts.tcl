echo "--- Running Clock Tree Synthesis ---"

openroad -no_init -log $RESULTS_DIR/cts.log << EOF
# Read LEF files
read_lef $PLATFORM_DIR/lef/NangateOpenCellLibrary.lef
read_lef $PLATFORM_DIR/tech/FreePDK45.tech.lef

# Read the detailed placed DEF
read_def $RESULTS_DIR/mips_detailed_placed.def

# Read the SDC
read_sdc $DESIGN_DIR/mips.sdc

# Read the Liberty file
read_liberty $PLATFORM_DIR/libs.ref/nangate45/lib/NangateOpenCellLibrary.lib

# Set clock port (crucial for CTS to identify your clock net)
# Make sure "clk_port" matches the actual clock port name in your mips.v and mips.sdc
set_attribute [get_db nets {clk}] is_clock true # This ensures OpenROAD treats it as a clock net

# Configure CTS (basic configuration)
set_db opt_cts_target_skew 0.05 # Example: Target skew of 0.05ns (50ps)
set_db opt_cts_balance_points true # Try to balance clock paths to common points
set_db opt_cts_buffer_cell {BUF_X1 BUF_X2 BUF_X4} # Example list of buffer cells to use (adjust based on your library)

# Run clock tree synthesis
clock_tree_synthesis

# Write the design to a DEF file
write_def $RESULTS_DIR/mips_cts.def

# Save a snapshot
save_image $RESULTS_DIR/mips_cts.png

# Report clock tree metrics (important for verification)
report_clocks
report_clock_tree
EOF

echo "CTS complete. DEF generated: $RESULTS_DIR/mips_cts.def"
