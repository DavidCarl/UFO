#! /bin/bash

TOWN0='London'

for i in {1..20}
do
   for j in {1..20}
   do
      (time find . -type f -print0 | xargs -0 -P $i grep -wrl '$TOWN0' > /dev/null) 2>> ./run_time_data/threads/$i
   done
done
