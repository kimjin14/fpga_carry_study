#!/bin/bash

width_options=(32 64 128 256 1024 1152 1200)
popcount_options=(xnor_popcount_verilog xnor_popcount_generic)

for module in "${popcount_options[@]}"
do
  sed -i "s/xnor_popcount.* \#/$module \#/g" xnor_popcount.v
  for width in "${width_options[@]}"
  do
    sed -i "s/localparam N = .*/localparam N = $width;/g" xnor_popcount.v

    quartus_map xnor_popcount.qsf
    quartus_fit xnor_popcount.qsf
    quartus_sta -t report_timing.tcl > ${module}_${width}.sta.rpt

    mv output_files/xnor_popcount.fit.rpt ${module}_${width}.fit.rpt
    mv output_files/xnor_popcount.fit.summary ${module}_${width}.fit.summary

    echo ${module}_${width}
    grep ALM ${module}_${width}.fit.summary

  done
done
