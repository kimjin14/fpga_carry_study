create_clock -period 1.0 -name clk [get_ports clk]
set_max_delay -from [get_ports in*] -to [get_ports sum*] 1
