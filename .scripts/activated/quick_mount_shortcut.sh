#!/usr/bin/fish 
#
#
#
#Mounts all the btrfs filesystems with noauto option in fstab 
set mountpoints (cat /etc/fstab | egrep '(noauto)' | awk '$3 == "btrfs" { print $2}' ) 


for mp in $mountpoints 



mount | grep $mp &> /dev/null 


if [ $status != 0 ]

    sudo mount $mp &> /dev/null 


else 

    sudo umount $mp &> /dev/null



end 






end



