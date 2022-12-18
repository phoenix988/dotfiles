#!/bin/bash


for check in $(ls $HOME/root-btrfs/timeshift-btrfs/snapshots/) ; do


sudo rm "$HOME/root-btrfs/timeshift-btrfs/snapshots/$check/@/var/lib/libvirt/images/debian11.qcow2"



done
