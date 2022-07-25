#!/bin/bash


for check in $(ls /home/karl/root-btrfs/timeshift-btrfs/snapshots/) ; do


sudo rm "/home/karl/root-btrfs/timeshift-btrfs/snapshots/$check/@/var/lib/libvirt/images/debian11.qcow2"



done
