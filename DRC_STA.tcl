echo "--- Running DRC and Post-Route Timing Analysis ---"

openroad -no_init -log $RESULTS_DIR/verification.log << EOF
# Read LEF files
read_lef $PLATFORM_DIR/lef/NangateOpenCellLibrary.lef
read_lef $PLATFORM_DIR/tech/FreePDK45.tech.lef

# Read the detailed routed DEF
read_def $RESULTS_DIR/mips_detailed_routed.def

# Read the SDC
read_sdc $DESIGN_DIR/mips.sdc

# Read the Liberty file
read_liberty $PLATFORM_DIR/libs.ref/nangate45/lib/NangateOpenCellLibrary.lib

# Generate SPEF (Standard Parasitic Exchange Format) for accurate timing.
# This extracts parasitic capacitances and resistances from the routed layout.
set spef_file $RESULTS_DIR/mips.spef
write_spef $spef_file

# --- DRC Check ---
# Run built-in DRC. This is a basic check; for production, dedicated DRC tools are used.
check_drc

# Print DRC violations (if any)
report_drc -file $RESULTS_DIR/mips_drc_report.txt

# --- Post-Route Static Timing Analysis (STA) ---
# Initialize STA engine
sta::read_libs [list $PLATFORM_DIR/libs.ref/nangate45/lib/NangateOpenCellLibrary.lib]
sta::read_sdc $DESIGN_DIR/mips.sdc
sta::read_def $RESULTS_DIR/mips_detailed_routed.def
sta::read_spef $spef_file # Crucial for accurate post-route timing
sta::init_timing

# Report worst slack (WNS - Worst Negative Slack)
sta::report_worst_slack
sta::report_timing -path_delay_type min_max -nworst 10 -max_paths 10 -setup -file $RESULTS_DIR/mips_post_route_timing.txt
sta::report_power -file $RESULTS_DIR/mips_power_report.txt

EOF

echo "DRC check complete. Report: $RESULTS_DIR/mips_drc_report.txt"
echo "SPEF generated: $RESULTS_DIR/mips.spef"
echo "Post-route STA complete. Reports: $RESULTS_DIR/mips_post_route_timing.txt, $RESULTS_DIR/mips_power_report.txt"
