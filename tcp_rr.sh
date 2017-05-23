#!/bin/bash

test="tcp_rr"
type="rr"

export test
export type

for rr in $trrp; do

sleep 3

	i=0
	while [ $i -lt $reps ]; do

		netperf -t TCP_RR -l $dur -H $vm1ip -- -r $rr, $rr -k all
		i=$((i+1))

	done > hold.txt
	./format_data.py < hold.txt
	rm hold.txt

done
