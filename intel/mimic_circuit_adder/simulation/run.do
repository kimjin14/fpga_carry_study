vlog -work work ../popcount_mimic_circuit_arch2.v
vlog -work work popcount_mimic_circuit_tb.v
vsim -L work -L altera popcount_mimic_circuit_tb
do wave.do
run -all 
