
create_clock -name clk -period 2.0 [get_ports clk]

set_output_delay 2.0 -clock clk [all_outputs]
set_clock_uncertainty 0.2 [get_clocks clk]
set_false_path -from [get_ports reset]

