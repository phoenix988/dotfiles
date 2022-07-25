#!/usr/bin/fish 


#This script will bind a folder from the location 
#Specified in the variable to my media music folder
#That way all my media will be located in one placei
#Even if I store it on another harddrive
#Modify the item variable to point to all your secondary locations
set item (ls /opt/media/music/)

for items in $item 



 [ -d /media/music/videos/$items ] || mkdir /media/music/videos/$items 


 set check_fstab (cat /etc/fstab | grep /opt/media/music/$items )


 [ -z $check_fstab ] &&  echo "/opt/media/music/$items /media/music/videos/$items none defaults,bind 0 0" >> /etc/fstab 


mount -a 2> /dev/null


end 


set check_fstab_old_entries (cat /etc/fstab | awk '/bind/ {print $1}' | awk -F '/' '{print $NF}')


for cfoe in $check_fstab_old_entries 
 
    set linenumber ( nl -b a /etc/fstab | grep $cfoe )
    set get_the_line ( echo $linenumber | awk '{print $1}' )

ls /media/music/videos/$cfoe  &> /dev/null || awk "NR!~/^($get_the_line)/"  /etc/fstab  >  ~/test.txt




end

