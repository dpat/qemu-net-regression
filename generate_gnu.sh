#!/bin/bash

#udp_rr plots
gnuplot -e "set terminal png; set ytics 2000; set output 'udp_rr_thr.png'; set xlabel 'req/resp size (bytes)'; set title 'Throughput udp rr'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'udp_rr_${qemu_old}.dat' using 2:xticlabels(1) with histograms title '${qemu_old}','udp_rr_${qemu_new}.dat' using 2:xticlabels(1) with histograms title '${qemu_new}'"

gnuplot -e "set terminal png; set ytics 2; set output 'udp_rr_lat.png'; set xlabel 'req/resp size (bytes)'; set title 'Avg. Latency udp rr'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'udp_rr_${qemu_old}.dat' using 3:xticlabels(1) with histograms title '${qemu_old}','udp_rr_${qemu_new}.dat' using 3:xticlabels(1) with histograms title '${qemu_new}'"

#udp_rr_burst plots
gnuplot -e "set terminal png; set ytics 5000; set output 'udp_rr_burst_thr.png'; set xlabel 'req/resp size (bytes)'; set title 'Throughput udp rr burst'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'udp_rr_burst_${qemu_old}.dat' using 2:xticlabels(1) with histograms title '${qemu_old}','udp_rr_burst_${qemu_new}.dat' using 2:xticlabels(1) with histograms title '${qemu_new}'"

gnuplot -e "set terminal png; set ytics 500; set output 'udp_rr_burst_lat.png'; set xlabel 'req/resp size (bytes)'; set title 'Avg. Latency udp rr burst'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'udp_rr_burst_${qemu_old}.dat' using 3:xticlabels(1) with histograms title '${qemu_old}','udp_rr_burst_${qemu_new}.dat' using 3:xticlabels(1) with histograms title '${qemu_new}'"

#tcp_rr plots
gnuplot -e "set terminal png; set ytics 2000; set output 'tcp_rr_thr.png'; set xlabel 'req/resp size (bytes)'; set title 'Throughput tcp rr'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'tcp_rr_${qemu_old}.dat' using 2:xticlabels(1) with histograms title '${qemu_old}','tcp_rr_${qemu_new}.dat' using 2:xticlabels(1) with histograms title '${qemu_new}'"

gnuplot -e "set terminal png; set ytics 5; set output 'tcp_rr_lat.png'; set xlabel 'req/resp size (bytes)'; set title 'Avg. Latency tcp rr'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'tcp_rr_${qemu_old}.dat' using 3:xticlabels(1) with histograms title '${qemu_old}','tcp_rr_${qemu_new}.dat' using 3:xticlabels(1) with histograms title '${qemu_new}'"

#tcp_stream plots
gnuplot -e "set terminal png; set ytics 20; set output 'tcp_str_thr.png'; set xlabel 'req/resp size (bytes)'; set title 'Throughput tcp str'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'tcp_stream_${qemu_old}.dat' using 2:xticlabels(1) with histograms title '${qemu_old}','tcp_stream_${qemu_new}.dat' using 2:xticlabels(1) with histograms title '${qemu_new}'"

gnuplot -e "set terminal png; set ytics 100; set output 'tcp_str_lat.png'; set xlabel 'req/resp size (bytes)'; set title 'Avg. Latency tcp str'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'tcp_stream_${qemu_old}.dat' using 3:xticlabels(1) with histograms title '${qemu_old}','tcp_stream_${qemu_new}.dat' using 3:xticlabels(1) with histograms title '${qemu_new}'"

#udp_stream plots
gnuplot -e "set terminal png; set ytics 1000; set output 'udp_str_thr.png'; set xlabel 'req/resp size (bytes)'; set title 'Throughput udp str'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'udp_stream_${qemu_old}.dat' using 2:xticlabels(1) with histograms title '${qemu_old}','udp_stream_${qemu_new}.dat' using 2:xticlabels(1) with histograms title '${qemu_new}'"

gnuplot -e "set terminal png; set ytics 0.1; set output 'udp_str_lat.png'; set xlabel 'req/resp size (bytes)'; set title 'Avg. Latency udp str'; set key outside; set style histogram clustered; set boxwidth 1; set style fill solid; plot 'udp_stream_${qemu_old}.dat' using 3:xticlabels(1) with histograms title '${qemu_old}','udp_stream_${qemu_new}.dat' using 3:xticlabels(1) with histograms title '${qemu_new}'"
