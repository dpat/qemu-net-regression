#!/bin/bash

# formats output data in gnuplot

if [[ $vir == y && $bm == y ]]
then
 cp generate_gnu.sh ${results_file}/virtio_bm
 cd ${results_file}/virtio_bm
 chmod +x generate_gnu.sh
 ./generate_gnu.sh
 rm generate_gnu.sh
 cd ../..
fi

if [[ $vho == y && $bm == y ]]
then
 cp generate_gnu.sh ${results_file}/vhost_bm
 cd ${results_file}/vhost_bm
 chmod +x generate_gnu.sh
 ./generate_gnu.sh
 rm generate_gnu.sh
 cd ../..
fi

if [[ $vir == y && $vm == y ]]
then
 sshpass -p "iforgot" scp -r root@${vm2ip}:virtio_vm ${results_file}/.
 cp generate_gnu.sh ${results_file}/virtio_vm
 cd ${results_file}/virtio_vm
 chmod +x generate_gnu.sh
 ./generate_gnu.sh
 rm generate_gnu.sh
 cd ../..
fi

if [[ $vho == y && $vm == y ]]
then
 sshpass -p "iforgot" scp -r root@${vm2ip}:vhost_vm ${results_file}/.
 cp generate_gnu.sh ${results_file}/vhost_vm
 cd ${results_file}/vhost_vm
 chmod +x generate_gnu.sh
 ./generate_gnu.sh
 rm generate_gnu.sh
 cd ../..
fi

