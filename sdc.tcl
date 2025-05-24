# Clock definition for clk_port in mips.v
create_clock -period 1000 -waveform {0 500} [get_ports clk]

# Input delay constraint (example for data_in)
set_input_delay -clock clk_port 0.5 [get_ports data_in]

# Output delay constraint (example for data_out)
set_output_delay -clock clk_port 0.5 [get_ports data_out]

# Set false paths or multi-cycle paths if applicable
# set_false_path -from [get_cells scan_test_reg*]






#Another Way
#current_design mips

#set clk_name  core_clock
#set clk_port_name clk
#set clk_period 2.2
#set clk_io_pct 0.2

#set clk_port [get_ports $clk_port_name]

#create_clock -name $clk_name -period $clk_period $clk_port

#set non_clock_inputs [lsearch -inline -all -not -exact [all_inputs] $clk_port]

#set_input_delay  [expr $clk_period * $clk_io_pct] -clock $clk_name $non_clock_inputs 
#set_output_delay [expr $clk_period * $clk_io_pct] -clock $clk_name [all_outputs]
