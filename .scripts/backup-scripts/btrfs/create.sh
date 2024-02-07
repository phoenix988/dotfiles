#!/usr/bin/bash 

#Here you choose your mountpoints where your btrfs filesystem is mounted on
#It will not work unless you mount the filesystem first
#Please note you need to have an entry in your fstab for it to work otherwise 
#you can also modify the variable "mountpoints" to directly specify your choosen mountpoints
#otherwise it will read your fstab for entries that have noauto as an option with btrfs filesystem
mountpoints=$(cat /etc/fstab | grep -E '(noauto)' | awk '$3 == "btrfs" { print $2}'  | grep -v .topbtrfs ) 

#Choose your date format 
DATE=$(date +%d-%h-%Y-%H-%M)

#The name of the directory were you will store your snapshots
snapshotdir="snapshots"


for mp in $mountpoints ; do
     
   [ -d $mp/$snapshotdir ] || mkdir $mp/$snapshotdir
   
   subvolumes=$(btrfs subvolume list $mp | awk '{print $NF}' | grep -v snapshots)
   subsubvolumes=$(btrfs subvolume list $mp | awk '{print $NF}' | grep -v snapshots | grep "/" )

   for sub in $subvolumes ; do
   
        backupname=$sub-$DATE
   
        btrfs subvolume snapshot $mp/$sub $mp/$snapshotdir/$backupname 2> /dev/null
   
   done 

   for sub in $subsubvolumes ; do
   
   	first=$(printf $sub | awk -F "/" '{print $1}') 
        second=$(printf $sub | awk -F "/" '{print $2}') 
   
        backupname=$second-$DATE
   
        btrfs subvolume snapshot $mp/$first/$second $mp/$snapshotdir/$backupname 2> /dev/null
   
   done 
  

done

