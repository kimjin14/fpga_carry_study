#!/usr/bin/python
"""
Summarizes top 10 delay paths from popcount
adds extra component delyas as well

"""

from pylab import *
import matplotlib.pyplot as plt
import sys
sys.path.insert(0, 'python')
import os
import csv
import copy
import re

input_file = str(sys.argv[1])
popcount_options = str(sys.argv[2])

flag_new_path = -1
path_counter = -1

# Extra delays due to these particular paths
COUT_DELAY = 0.0
SUMOUT_DELAY = 0.017
ADDER_DELAY = 0.034

total_delay = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
total_extra_delay = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
reported_delay = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

with open(input_file) as f:
  for line in f:
    if "Slack" in line: # found start of that path
      path_counter = path_counter + 1

      line_breakdown = line.split()
      slack = line_breakdown[3]
      reported = float(slack[:-2])
      reported_delay[path_counter] = 1 - reported 

      for i in range(29):
        line = next(f)
      flag_new_path = 1
    elif "--------" in line:
      flag_new_path = -1

    if flag_new_path == 1:
      # break each line into pieces to check delay type + delay value
      # check for net/carry which ahve diff format
      #if "net" in line_breakdown:
      if "CARRY" in line:
        line = next(f)
        line = "a b c" + line
        line_breakdown = line.split()
      else:
        line_breakdown = line.split()

      # formatting is wrong, skip it if last line
      if "FDRE" not in line:
        incr_delay = float(line_breakdown[3]) # 2=total, 3=incr, 4=edge, 5=type, 8=element
        total_delay[path_counter]+=incr_delay
  
      # for diff arch, add diff extra delay
      if "arch1" in popcount_options:
        element = line_breakdown[1]
        if "LUT" in element:
          total_extra_delay[path_counter]+=SUMOUT_DELAY
        elif "CARRY" in element:
          total_extra_delay[path_counter]+=COUT_DELAY
      elif "arch2" in popcount_options:
        element = line_breakdown[1]
        if "LUT" in element:
          total_extra_delay[path_counter]+=(SUMOUT_DELAY+ADDER_DELAY)
        elif "CARRY" in element:
          total_extra_delay[path_counter]+=COUT_DELAY 

#print total_extra_delay

for i in range(10):
  reported_delay[i]+=total_extra_delay[i]

#print total_delay.index(max(total_delay)), max(total_delay), total_extra_delay.index(max(total_extra_delay)), max(total_extra_delay)
#print max(total_extra_delay)
print max(reported_delay)
