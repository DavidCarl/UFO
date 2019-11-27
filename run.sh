#! /bin/bash

TOWN0='London'
TOWN1='Berlin'
TOWN2='Odense'
for i in {1..100}
do
   echo $i
   (time grep -wrl '$TOWN0' ./zipfiles/target > /dev/null) 2>> ./res/$TOWN0
   (time grep -wrl '$TOWN1' ./zipfiles/target > /dev/null) 2>> ./res/$TOWN1
   (time grep -wrl '$TOWN2' ./zipfiles/target > /dev/null) 2>> ./res/$TOWN2
done
