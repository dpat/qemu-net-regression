#!/bin/bash

sleep 1

test="udp_stream"
type="stream"

export test
export type

for msg_size in $ustp; do

sleep 3

	i=0
	while [ $i -lt $reps ]; do

		netperf -t UDP_STREAM -l $dur -H $vm1ip -- -m $msg_size -k all
		i=$((i+1))

	done > hold.txt

	./format_data.py < hold.txt
	rm hold.txt

done
