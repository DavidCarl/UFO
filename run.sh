#! /bin/bash

TOWN0='London'
TOWN1='Berlin'
TOWN2='Odense'
for i in {1..100}
do
   (time grep -wrl '$TOWN0' ./zipfiles/target > /dev/null) 2>> ./run_time_data/$TOWN0
   (time grep -wrl '$TOWN1' ./zipfiles/target > /dev/null) 2>> ./run_time_data/$TOWN1
   (time grep -wrl '$TOWN2' ./zipfiles/target > /dev/null) 2>> ./run_time_data/$TOWN2
done
