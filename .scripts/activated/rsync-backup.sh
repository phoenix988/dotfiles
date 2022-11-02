#!/bin/bash

#This script will create rsync backups
#use main to run it

backup_path="$HOME/Yandex.Disk/Scripts"

declare -a options=(

    "$HOME/.scripts/"
    "$HOME/.dmenu/"

)

declare -a sym_options=(


)



backup_files=$(printf '%s\n' "${options[@]}") 
sym_files=$(printf '%s\n' "${sym_options[@]}") 


for backup in $backup_files ; do
  
    for bp in $backup_path ; do 

    
    [ -d $bp ] || mkdir -p $bp

    location=$($echo $backup | awk -F / '{ print $NF }' )

    rsync -avh $backup $bp/$location/ 

done

done




for sym in $sym_files ; do

    for bp in $backup_path ; do 

    location=$(echo $sym | awk -F / '{ print $4 }' )


    rsync -avh $sym $bp/$location/

done


done



