#!/bin/bash

#files=(final_xnor_pop final_xnor_pop_arch)
#width_options=(32 64 128 256 1024 1152 1200)
#popcount_options=(final_xnor_pop/xnor_popcount_generic final_xnor_pop/xnor_popcount_verilog final_xnor_pop_arch/xnor_popcount_arch1 final_xnor_pop_arch/xnor_popcount_arch2)
#files=(final_xnor_pop)
width_options=(32 64 128 256)
popcount_options=(final_xnor_pop/report_new/xnor_popcount_generic final_xnor_pop/report_new/xnor_popcount_verilog final_xnor_pop/report_new/xnor_popcount_verilog_reg final_xnor_pop_arch/report_new/xnor_popcount_arch1 final_xnor_pop_arch/report_new/xnor_popcount_arch1_reg final_xnor_pop_arch/report_new/xnor_popcount_arch2 final_xnor_pop_arch/report_new/xnor_popcount_arch2_reg)
#popcount_options=(final_xnor_pop/report_new/xnor_popcount_generic final_xnor_pop/report_new/xnor_popcount_verilog final_xnor_pop/report_new/xnor_popcount_verilog_reg)
seeds=(1 100 1000 353234 1023830)

AREA=0
DELAY=1

if [ $AREA -eq 1 ]
then
  for module in "${popcount_options[@]}"
  do
    for width in "${width_options[@]}"
    do
      resource="$module,$width,"
      for seed in "${seeds[@]}"
      do
        dut_resource=$(grep  "; Fitter Resource Utilization by Entity" ${module}_${width}_${seed}.fit.rpt -A 20 | grep "xnor_popcount:dut|" -m 1)
        line=$(echo $dut_resource | cut -d ' ' -f4)
        resource+="$line,"
      done
      echo $resource
    done
  done
fi

if [ $DELAY -eq 1 ]
then
  for module in "${popcount_options[@]}"
  do
    for width in "${width_options[@]}"
    do
      delay="$module,$width,"
      for seed in "${seeds[@]}"
      do
        delays=$(./summarize_delay.py ${module}_${width}_${seed}.sta.rpt $module)
        delay+="$delays,"
      done
      echo $delay
    done
  done
fi

