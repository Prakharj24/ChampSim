TRACE_DIR=/home/prakhar/traces
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/prakhar/ChampSim/DRAMSim2/
binary=${1}
n_warm=${2}
n_sim=${3}
option=${5}
temp_num=${4}

mkdir -p results_mix_4core

while [ "$temp_num" -le 201 ]
do
	num=$temp_num
	while [ "$num" -le `expr $temp_num + 8`  ] && [ "$num" -le 201 ];
	do
		trace1=`sed -n ''$num'p' sim_list/4core_workloads.txt | awk '{print $1}'`
		trace2=`sed -n ''$num'p' sim_list/4core_workloads.txt | awk '{print $2}'`
		trace3=`sed -n ''$num'p' sim_list/4core_workloads.txt | awk '{print $3}'`
		trace4=`sed -n ''$num'p' sim_list/4core_workloads.txt | awk '{print $4}'`

		(./bin/${binary} -warmup_instructions ${n_warm}000000 -simulation_instructions ${n_sim}000000 ${option} -traces ${TRACE_DIR}/${trace1}.trace.gz ${TRACE_DIR}/${trace2}.trace.gz ${TRACE_DIR}/${trace3}.trace.gz ${TRACE_DIR}/${trace4}.trace.gz) &> results_mix_4core/mix${num}-${binary}${option}.txt &
		num=`expr $num + 1`
	done
wait ${!}
temp_num=$num
done
