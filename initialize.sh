#!/bin/bash

# install gdebi to aide in the installation of different QEMU versions
apt-get --yes --force-yes install gdebi
apt-get --yes --force-yes install gnuplot
apt-get --yes --force-yes install openssh-client
apt-get --yes --force-yes install openssh-server
apt-get --yes --force-yes install sshpass

# downloads and prepares specified QEMU versions for install
if [ ! -d qemu-${qemu_old} ]; then
 wget http://download.qemu-project.org/qemu-${qemu_old}.tar.bz2
 tar xvjf qemu-${qemu_old}.tar.bz2
 cd qemu-${qemu_old}
 ./configure
 make
 cd ..
fi

if [ ! -d qemu-${qemu_new} ]; then
 wget http://download.qemu-project.org/qemu-${qemu_new}.tar.bz2
 tar xvjf qemu-${qemu_new}.tar.bz2
 cd qemu-${qemu_new}
 ./configure
 make
 cd ..
fi

# downloads default images
if [ $custim == y ]; then
 rm root1.qcow root2.qcow
 wget https://www.dropbox.com/s/1agbcwsc23yf5rk/root1.qcow?dl=0
 sleep 5
 mv root1.qcow?dl=0 root1.qcow
 cp root1.qcow root2.qcow
 vm1iso=root1.qcow
 vm2iso=root2.qcow
 export vm1iso vm2iso
fi

chmod +x ifup
chmod +x regression_test.sh
chmod +x format_results.sh
chmod +x udp_rr.sh
chmod +x tcp_rr.sh
chmod +x udp_stream.sh
chmod +x tcp_stream.sh
chmod +x netperf_test_suite1.sh
chmod +x format_data.py
chmod +x hlinux_virtio_vm.sh
chmod +x hlinux_vhost_vm.sh
chmod +x hlinux_macvtap_vm.sh
chmod +x generate_gnu.sh

# installs necessary QEMU software
apt-get --yes install qemu libcap2-bin bridge-utils socat openssh-server sshpass

# customizes and initializes default images to specifications
if [ $custim == y ]; then

 brctl addbr $brid
 ifconfig $brid up
 brctl addif $brid $phid
 ifconfig $brid 150.150.150.10

 vmmac=$vm1mac
 vmiso=$vm1iso
 export vmmac vmiso
 ./hlinux_virtio_vm.sh &
 sleep 30
 sed -i "/ifconfig/c ifconfig eth0:0 $vm1ip" rc.local
 sshpass -p "password" scp -o "StrictHostKeyChecking no" rc.local root@150.150.150.1:/etc/rc.local
 sleep 5
 sshpass -p "password" ssh -o "StrictHostKeyChecking no" root@150.150.150.1 "echo 'root:$vm1pw' | chpasswd"
 sleep 15
 kill $(pidof qemu-system-x86_64)

 # edit this for custim
 if [ $vm == y ]; then
  vmmac=$vm2mac
  vmiso=$vm2iso
  export vmmac vmiso
  ./hlinux_virtio_vm.sh &
  sleep 30
  sed -i "/ifconfig/c ifconfig eth0:0 $vm2ip" rc.local
  sshpass -p "password" scp -o "StrictHostKeyChecking no" rc.local root@150.150.150.1:/etc/rc.local
  sleep 5
  sshpass -p "password" ssh -o "StrictHostKeyChecking no" root@150.150.150.1 "echo 'root:$vm2pw' | chpasswd"
  sleep 5
  sshpass -p "password" scp -o "StrictHostKeyChecking no" udp_rr.sh tcp_rr.sh udp_stream.sh tcp_stream.sh netperf_test_suite1.sh format_data.py root@150.150.150.1:.
  sleep 15
  kill $(pidof qemu-system-x86_64)
 fi

 brctl delif $brid $phid
 ifconfig $brid down
 brctl delbr $brid

fi

exit 0
