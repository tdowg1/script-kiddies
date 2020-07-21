#!/bin/bash

for i in $(seq 1 $((10#$(date +%N) % 10)))+1
do
if [ $((i % 5)) == $((10#$(date +%N) % 5)) ]
then
printf 'Bryn'
elif [ $((i % 3)) == $((10#$(date +%N) % 3)) ]
then
printf '<3'
else
printf '8'; printf '=%.0s' $(seq 1 $((10#$(date +%N) % 7))); printf 'D'
fi
done
printf '\n'
