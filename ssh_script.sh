#!/bin/bash

chmod +x initialize.sh

results_file="results_$qemu_new+$qemu_old"
if [ ! -d "$results_file" ]; then
 mkdir $results_file
fi

export qemu_old qemu_new results_file
# installs necessary test scripts and software on a chosen server
./initialize.sh

# installs the reference QEMU version (qemu_old)
cd qemu-${qemu_old}
make install
cd ..
qemu_ver=$qemu_old
export qemu_ver
./regression_test.sh

# installs the version of QEMU to be tested (qemu_new)
cd qemu-${qemu_new}
make install
cd ..
qemu_ver=$qemu_new
export qemu_ver
./regression_test.sh

# opens vm2 to view vm-vm test results, formats results with gnuplot
if [ $vm == y ]
then
 vmmac=$vm2mac
 vmiso=$vm2iso
 export vmiso vmmac
 ./hlinux_virtio_vm.sh &
 sleep 30
fi
./format_results.sh

kill $(pidof qemu-system-x86_64)

# clean up networking
brctl delif $brid $phid
ifconfig $brid down
brctl delbr $brid
