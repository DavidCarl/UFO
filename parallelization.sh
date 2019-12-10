#! /bin/sh

for i in {1..24} # 24 being the parallel thead count
do
    (time grep -wrl "London" > /dev/null) 2>> ./run_time_data/parallel/24 &
done