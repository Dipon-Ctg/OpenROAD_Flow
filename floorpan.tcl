echo "--- Running Floorplanning ---"

openroad -no_init -log $RESULTS_DIR/floorplan.log << EOF
# Read LEF files for technology and standard cells (physical view)
read_lef $PLATFORM_DIR/lef/NangateOpenCellLibrary.lef
read_lef $PLATFORM_DIR/tech/FreePDK45.tech.lef

# Read the gate-level netlist (YOUR provided mips.v)
read_verilog $DESIGN_DIR/mips.v

# Read SDC for constraints
read_sdc $DESIGN_DIR/mips.sdc

# Read Liberty file (for timing information of cells)
read_liberty $PLATFORM_DIR/libs.ref/nangate45/lib/NangateOpenCellLibrary.lib

# Initialize the design (assigns pins, creates block, etc.)
init_floorplan

# --- Floorplan Parameters (adjust as needed) ---
# A typical core utilization is 0.6-0.7 for good routability.
set core_utilization 0.7
set core_aspect_ratio 1.0 # 1.0 for a square core

# Example fixed die size (adjust based on your expected design size)
# If your design is very small or very large, you'll need to adjust these.
# You can estimate needed area by counting cells and multiplying by typical cell area.
set die_width  1000.0
set die_height 1000.0

# Determine site row height from LEF for proper row alignment
set site_name "FreePDK45_38nm_3x20_10R_NP_162ROW" # Common site name for Nangate45
set site_def [get_db sites $site_name]
set row_height [lindex [get_db $site_def -_row_height] 0]

# Core origin (lower-left X, Y) - often a percentage of die size for padding
set core_lx [expr $die_width * 0.05]
set core_ly [expr $die_height * 0.05]

# Core dimensions based on utilization and die size
set core_width  [expr $die_width * 0.9]
set core_height [expr $die_height * 0.9]

# Align core height to a multiple of row_height
set core_height_aligned [expr floor($core_height / $row_height) * $row_height]
set core_uy_aligned [expr $core_ly + $core_height_aligned]

# Final core upper-right coordinates
set core_ux [expr $core_lx + $core_width]
set core_uy $core_uy_aligned

# Create floorplan
# floorplan die_lx die_ly die_ux die_uy core_lx core_ly core_ux core_uy
floorplan 0 0 $die_width $die_height $core_lx $core_ly $core_ux $core_uy \
          -row_height $row_height \
          -site $site_name \
          -utilization $core_utilization \
          -aspect_ratio $core_aspect_ratio

# Define power straps and rings (basic example, adjust based on your needs)
# These are crucial for supplying power to your cells.
set metal1 "metal1"
set metal2 "metal2"

add_global_power_straps -net VDD -pitch 100 -width 5 -layer $metal1
add_global_power_straps -net VSS -pitch 100 -offset 50 -width 5 -layer $metal1

# Commit changes (essential after floorplan commands)
commit_floorplan

# Write the design to a DEF file
write_def $RESULTS_DIR/mips_floorplanned.def

# Save a snapshot for visual inspection
save_image $RESULTS_DIR/mips_floorplanned.png
EOF

echo "Floorplanning complete. DEF generated: $RESULTS_DIR/mips_floorplanned.def"
