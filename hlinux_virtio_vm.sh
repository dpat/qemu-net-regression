#!/bin/sh

qemu-system-x86_64 -machine q35,accel=kvm -drive if=none,id=vda,file=$vmiso -device virtio-blk-pci,drive=vda -netdev type=tap,id=net0,script=./ifup -device virtio-net-pci,netdev=net0,mac=$vmmac
