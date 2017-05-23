#!/bin/bash

sleep 1

test="udp_rr"
type="rr"

export test
export type

for rr in $urrp; do

sleep 3

        i=0
        while [ $i -lt $reps ]; do

                netperf -t UDP_RR -l $dur -H $vm1ip -- -r $rr,$rr -k all
                i=$((i+1))

        done > hold.txt
	./format_data.py < hold.txt
	rm hold.txt

done

test="udp_rr_burst"

export test

sleep 1

for burst in $urbp; do

sleep 3

        i=0
        while [ $i -lt $reps ]; do

                netperf -t UDP_RR -l $dur -H $vm1ip -- -b $burst -k all
                i=$((i+1))

        done > hold.txt
	./format_data.py < hold.txt
	rm hold.txt

done


