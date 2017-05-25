#!/bin/bash

# setup bridged networking
if [[ $vir == y || $vho == y ]]
then
 brctl addbr $brid
 ifconfig $brid up
 brctl addif $brid $phid
 ifconfig $brid $brip
fi

# test virtio backend bm to vm
if [[ $vir == y && $bm == y ]]
then
 vmmac=$vm1mac
 vmiso=$vm1iso
 export vmmac vmiso
 ./hlinux_virtio_vm.sh &
 backend="virtio_bm"
 export backend
 sleep 30
 ./netperf_test_suite1.sh
 kill $(pidof qemu-system-x86_64)
fi

# test virtio backend vm to vm
if [[ $vir == y && $vm == y ]]
then
 vmmac=$vm1mac
 vmiso=$vm1iso
 export vmmac vmiso
 ./hlinux_virtio_vm.sh &
 vmmac=$vm2mac
 vmiso=$vm2iso
 export vmmac vmiso
 ./hlinux_virtio_vm.sh &
 sleep 30
 sshpass -p $vm2pw ssh -o "StrictHostKeyChecking no" root@${vm2ip} "qemu_ver='$qemu_ver' && export qemu_ver && results_file='$results_file' && export results_file && vm1ip='$vm1ip' && export vm1ip && dur=$dur && export dur && reps=$reps && export reps && urrp='$urrp' && export urrp && urbp='$urbp' && export urbp && ustp='$ustp' && export ustp && trrp=$trrp && export trrp && tstp='$tstp' && export tstp && backend='virtio_vm' && export backend && ./netperf_test_suite1.sh"
 kill $(pidof qemu-system-x86_64)
fi

# test vhost backend bm to vm
if [[ $vho == y && $bm == y ]]
then
 vmmac=$vm1mac
 vmiso=$vm1iso
 ./hlinux_vhost_vm.sh &
 backend="vhost_bm"
 export backend
 sleep 30
 ./netperf_test_suite1.sh
 kill $(pidof qemu-system-x86_64)
fi

# test vhost backend vm to vm
if [[ $vho == y && $vm == y ]]
then
 vmmac=$vm1mac
 vmiso=$vm1iso
 ./hlinux_vhost_vm.sh &
 vmmac=$vm2mac
 vmiso=$vm2iso
 ./hlinux_vhost_vm.sh &
 sleep 30
 sshpass -p $vm2pw ssh -o "StrictHostKeyChecking no" root@${vm2ip} "qemu_ver='$qemu_ver' && export qemu_ver && results_file='$results_file' && export results_file && vm1ip='$vm1ip' && export vm1ip && dur=$dur && export dur && reps=$reps && export reps && urrp='$urrp' && export urrp && urbp='$urbp' && export urbp && ustp='$ustp' && export ustp && trrp=$trrp && export trrp && tstp='$tstp' && export tstp && backend='vhost_vm' && export backend && ./netperf_test_suite1.sh"
 kill $(pidof qemu-system-x86_64)
fi

