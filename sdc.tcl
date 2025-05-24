# Clock definition for clk_port in mips.v
create_clock -period 1000 -waveform {0 500} [get_ports clk]

# Input delay constraint (example for data_in)
set_input_delay -clock clk_port 0.5 [get_ports data_in]

# Output delay constraint (example for data_out)
set_output_delay -clock clk_port 0.5 [get_ports data_out]

# Set false paths or multi-cycle paths if applicable
# set_false_path -from [get_cells scan_test_reg*]
