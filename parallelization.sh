#! /bin/sh

for i in {1..$1} #threads
do
      (time grep -wrl 'London' > /dev/null) 2>> ./run_time_data & (time grep -wrl 'Odense' > /dev/null) 2>> ./run_time_data & (time grep -wrl 'Berlin' > /dev/null) 2>> ./run_time_data & (time grep -wrl 'New York' > /dev/null) 2>> ./run_time_data
done
