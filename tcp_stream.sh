#!/bin/bash

sleep 1

test="tcp_stream"
type="stream"
export test
export type

for msg_size in $tstp; do

sleep 3

	i=0
	while [ $i -lt $reps ]; do

		netperf -t TCP_STREAM -l $dur -H $vm1ip -- -m $msg_size -s 0 -S 0 -k all
		i=$((i+1))

	done > hold.txt
	./format_data.py < hold.txt
	rm hold.txt

done
