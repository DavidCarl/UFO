#! /bin/sh

for i in {1..$1} #threads
do
      (time grep -wrl 'London' > /dev/null) 2>> ./run_time_data &
done
