
TRACE_DIR=/home/prakhar/traces
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/prakhar/ChampSim/DRAMSim2/
binary=${1}
n_warm=${2}
n_sim=${3}
start=${4}
end=${5}
mkdir -p results_8core

while [ "$start" -le "$end" ]
do
	num=$start
	while [ "$num" -le `expr $start + 8`  ] && [ "$num" -le "$end" ];
	do
            echo "Running benchmark ${num}!"
            trace1=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $1}'`
            trace2=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $2}'`
            trace3=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $3}'`
            trace4=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $4}'`
            trace5=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $5}'`
            trace6=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $6}'`
            trace7=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $7}'`
            trace8=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $8}'`

            (./bin/${binary} -warmup_instructions ${n_warm}000000 -simulation_instructions ${n_sim}000000 ${option} -traces ${TRACE_DIR}/${trace1}.trace.gz ${TRACE_DIR}/${trace2}.trace.gz ${TRACE_DIR}/${trace3}.trace.gz ${TRACE_DIR}/${trace4}.trace.gz ${TRACE_DIR}/${trace5}.trace.gz ${TRACE_DIR}/${trace6}.trace.gz ${TRACE_DIR}/${trace7}.trace.gz ${TRACE_DIR}/${trace8}.trace.gz) &> results_8core/mix${num}-${binary}.txt &
		num=`expr $num + 1`
	done
wait ${!}
start=$num
echo "set finished!"
done
