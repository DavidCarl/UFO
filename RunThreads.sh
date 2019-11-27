#! /bin/bash

TOWN0='London'

for i in {1..20}
do
   for j in {1..100}
   do
      echo "$i, $j"
      (time find . -type f -print0  | xargs -0 -P $i grep -wrl '$TOWN0' ./zipfiles/target > /dev/null) 2>> ./res/$i
   done
done
