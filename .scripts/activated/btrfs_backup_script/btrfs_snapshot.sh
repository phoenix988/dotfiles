#!/usr/bin/fish 


#Here you choose your mountpoints where your btrfs filesystem is mounted on
#If its not mounted already this script will mount it for you and unmount it
#Please note you need to have an entry in your fstab for it to work otherwise 
#you need to modify it to also specify the device
set mountpoints (cat /etc/fstab | egrep '(noauto)' | awk '$3 == "btrfs" { print $2}'  | grep -v .topbtrfs ) 




#Choose your date format 
set DATE (date +%d%m%Y-%H%M)

#The name of the directory wherte you will store snapshots
set snapshotdir ".snapshots"

for mp in $mountpoints 



set subvolumes (btrfs subvolume list $mp | awk '{print $9}' | grep -v .snapshot)

for sub in $subvolumes 

    set backupname $sub-$DATE

 btrfs subvolume snapshot $mp/$sub $mp/$snapshotdir/$backupname 2> /dev/null

end


end
