set oDir "report/"
set oResource test_res.rpt
set oTiming test_time.rpt

open_project project/project.xpr
synth_design -top fpga_top -part xc7z045ffg900-2 -mode out_of_context
opt_design
place_design
route_design
report_utilization -hierarchical -file $oDir/$oResource
report_timing -max_paths 10 -file $oDir/$oTiming
exit
