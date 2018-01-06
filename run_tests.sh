echo -n "Executing next_line prefetcher simulations"
./run_4core.sh bimodal-no-next_line-lru-4core 100 100 101 & ./run_4core.sh bimodal-no-next_line-lru-4core 100 100 102 & ./run_4core.sh bimodal-no-next_line-lru-4core 100 100 103 &

echo -n "Executing ip_line prefetcher simulations"
./run_4core.sh bimodal-no-ip_stride-lru-4core 100 100 101 & ./run_4core.sh bimodal-no-ip_stride-lru-4core 100 100 102 & ./run_4core.sh bimodal-no-ip_stride-lru-4core 100 100 103 &

echo -n "Executing without prefetcher simulations"
./run_4core.sh bimodal-no-no-lru-4core_test 100 100 101 & ./run_4core.sh bimodal-no-no-lru-4core_test 100 100 102 & ./run_4core.sh bimodal-no-no-lru-4core_test 100 100 103 &


echo -n "Executing same benchmark simulations"
./run_4core.sh bimodal-no-ip_stride-lru-4core 100 100 104 &
./run_4core.sh bimodal-no-ip_stride-lru-4core 100 100 105 &
./run_4core.sh bimodal-no-ip_stride-lru-4core 100 100 106 &
./run_4core.sh bimodal-no-no-lru-4core_test 100 100 104 &
./run_4core.sh bimodal-no-no-lru-4core_test 100 100 105 &
./run_4core.sh bimodal-no-no-lru-4core_test 100 100 106 &
