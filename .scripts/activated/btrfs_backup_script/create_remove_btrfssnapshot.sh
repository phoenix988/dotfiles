#!/usr/bin/fish 



#Check the fstab for all the btrfs volumes that you want to take snapshots of 
#make sure you have the noauto option enabled
#If you want to filter out any mountpoints you can do that here too
set mountpoints (cat /etc/fstab | egrep '(noauto)' | awk '$3 == "btrfs" { print $2}' | grep -v .topbtrfs  )


#Unmounts if any filesystem is currently mounted 
#Because otherwise if any filesystem is mounted you might get some undesirable effects.
for mp in $mountpoints 


mount | grep $mp &> /dev/null && umount $mp 


end


#This for loop will mount the filesystem one by one
#And creates the snapshots
for mp in $mountpoints 


mount | grep $mp &> /dev/null || mount $mp


#Creates the snapshot location if it doesnt exist
ls "$mp/.snapshots" &> /dev/null || btrfs subvolume create $mp/.snapshots



#This will create the snapshots
/usr/bin/myscripts/btrfs_backup_script/btrfs_snapshot.sh $mp 2> /dev/null 
#This will delete old snapshots
/usr/bin/myscripts/btrfs_backup_script/delete_old_btrfs_snapshots.sh $mp 2> /dev/null



#Unmounts the drive
umount $mp 2> /dev/null

end 






