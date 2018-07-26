#!/bin/bash

#files=(final_xnor_pop final_xnor_pop_arch)
#width_options=(32 64 128 256 1024 1152 1200)
#popcount_options=(final_xnor_pop/xnor_popcount_generic final_xnor_pop/xnor_popcount_verilog final_xnor_pop_arch/xnor_popcount_arch1 final_xnor_pop_arch/xnor_popcount_arch2)
#files=(final_xnor_pop)
dir1=final_xnor_pop/report
dir2=final_xnor_pop_arch/report
width_options=(32 64 128 256)
popcount_options=($dir1/xnor_popcount_generic $dir1/xnor_popcount_verilog $dir1/xnor_popcount_verilog_reg $dir2/xnor_popcount_arch1 $dir2/xnor_popcount_arch1_reg $dir2/xnor_popcount_arch2 $dir2/xnor_popcount_arch2_reg)
#seeds=(1 100 1000 353234 1023830)

AREA=0
DELAY=1

echo "AREA"
if [ $AREA -eq 1 ]
then
  for module in "${popcount_options[@]}"
  do
    for width in "${width_options[@]}"
    do
      resource="$module,$width,"
      #for seed in "${seeds[@]}"
      #do
        dut_resource=$(grep  "dut" ${module}_${width}.resource.rpt -m1)
        line=$(echo $dut_resource | cut -d ' ' -f6)
        resource+="$line,"
      #done
      echo $resource
    done
  done
fi

echo "DELAY"
if [ $DELAY -eq 1 ]
then
  for module in "${popcount_options[@]}"
  do
    for width in "${width_options[@]}"
    do
      delay="$module,$width,"
      #for seed in "${seeds[@]}"
      #do
        delays=$(./summarize_delay.py ${module}_${width}.timing.rpt $module)
        delay+="$delays,"
      #done
      echo $delay
    done
  done
fi

