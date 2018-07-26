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
with open(input_file) as f:
  for line in f:
    if "From Node" in line: # found start of that path
      flag_new_path = 11 # skip this many lines
      path_counter+=1
    elif "Data Required Path" in line:
      flag_new_path = -1

    if flag_new_path > 0:
      flag_new_path -= 1
    elif flag_new_path == 0:
      line_breakdown = line.split()
      incr_delay = float(line_breakdown[3]) # 2=total, 3=incr, 4=edge, 5=type, 8=element
      total_delay[path_counter]+=incr_delay
      if "arch1" in popcount_options:
        element = line_breakdown[8]
        #print element
        if "cout" in element:
          total_extra_delay[path_counter]+=COUT_DELAY
        elif "sumout" in element:
          total_extra_delay[path_counter]+=SUMOUT_DELAY
      elif "arch2" in popcount_options:
        element = line_breakdown[8]
        if "cout" in element:
          total_extra_delay[path_counter]+=COUT_DELAY
        elif "sumout" in element:
          total_extra_delay[path_counter]+=(SUMOUT_DELAY+ADDER_DELAY)
#print total_extra_delay

for i in range(10):
  total_extra_delay[i]+=total_delay[i]

#print total_delay.index(max(total_delay)), max(total_delay), total_extra_delay.index(max(total_extra_delay)), max(total_extra_delay)
print max(total_extra_delay)
