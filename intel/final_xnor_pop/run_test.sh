#!/bin/bash

#width_options=(32 64 128 256 1024 1152 1200)
width_options=(32 64 128 256)
popcount_options=(xnor_popcount_verilog_reg xnor_popcount_verilog xnor_popcount_generic)
seeds=(1 100 1000 353234 1023830)

for module in "${popcount_options[@]}"
do
  sed -i "s/xnor_popcount_.* \#/$module \#/g" xnor_popcount.v
  for width in "${width_options[@]}"
  do
    sed -i "s/localparam N = .*/localparam N = $width;/g" xnor_popcount.v
    
    for seed in "${seeds[@]}"
    do
      quartus_map xnor_popcount.qsf
      quartus_fit -seed $seed xnor_popcount.qsf
      quartus_sta -t report_timing.tcl > report_new/${module}_${width}_${seed}.sta.rpt

      mv output_files/xnor_popcount.fit.rpt report_new/${module}_${width}_${seed}.fit.rpt
      mv output_files/xnor_popcount.fit.summary report_new/${module}_${width}_${seed}.fit.summary

    done
  done
done
