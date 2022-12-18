#!/bin/bash

VM_NAME="ubuntu01"
MEM_SIZE="1024"
VCPUS="4"
ISO_FILE='http://archive.ubuntu.com/ubuntu/dists/trusty/main/installer-amd64/'
DISK_SIZE="20"



sudo virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --location ${ISO_FILE} \
     --disk size=${DISK_SIZE}  \
     --network network=eth-nat \
     --graphics=none \
     --unattended \
      user-password-file="$HOME/.password"
     #--console pty,target_type=serial \
     #--initrd-inject $HOME/Documents/kickstart/pressed.cfg --extra-args="inst.ks=file:/pressed.cfg console=tty0 console=ttyS0,115200n8"
     #--extra-args="ks=http://192.168.122.1/ks.cfg console=tty0 console=ttyS0,115200n8"
