#!/bin/bash



mount | grep .bx500 &> /dev/null

[ $? != "0" ] && sudo mount /mnt/.bx500/

cd /mnt/.bx500/media/.pictures/


date=$( date +%d%m%Y-%H%M )
name_of_temp_tar="xp_$date.tar"
backup_location="/media/cloud_storage/gpg/"
folder_to_backup="/mnt/.bx500/media/.pictures/"

tar -cf $backup_location/$name_of_temp_tar $folder_to_backup 

gpg --encrypt -r karlfredin@gmail.com $backup_location/$name_of_temp_tar

rm -f $backup_location/$name_of_temp_tar 
