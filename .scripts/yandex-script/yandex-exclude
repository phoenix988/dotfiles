#!/bin/bash
####################################################################
#############        Yandex-exclusion Script        ################
####################################################################
#Script that makes it easy to exclude folders from yandex sync     #
#Useful if you dont want big folder to take space on your harddrive#
####################################################################
#Path to your yandex disk folder
yandex_path="$HOME/Yandex.Disk"

#Path to yandex config
yandex_config="$HOME/.config/yandex-disk/config.cfg"

#Loops until you write a for add or r for remove
until [ "$yes_no" = "a" -o "$yes_no" = "r" ] ; do

     clear
     
     read -p "Do you want to add or remove an Yandex folder exclusion? [a/r]: " yes_no
     
     clear
     
     
     done

#Runs this if you choose to add exclusion
if [ "$yes_no" = "a" ] ; then

    #Lists all your alternatives
    list=$(ls $yandex_path | nl )

    #Asks you which folder you want to exclude
    read -p "Which folder do you want to add these are available
    $list :" choice
       
    clear
    
    #Converts the number you did answer to the correct string  
    choice_new=$(printf '%s\n' "${list[@]}" | grep -m 1 $choice | awk '{print $2}')
    #Gets the last folder in your exclude list so it can add the new folder behind it
    last_item=$(cat $yandex_config | grep exclude | awk -F , '{print $NF}' | sed 's/"//g')
    #Gets the line number of the exclude enttry
    line=$(cat $yandex_config | nl | grep "exclude" | awk '{print $1}')
    
    #Chaning the file using awk
    awk -i inplace -v row=$line -v new_text="$last_item,$choice_new"  "NR==row{sub(/$last_item/,new_text)} 1" $yandex_config
    
#Runs this if you choose to remove exclusion
else

    #Lists all the alternatives you can remove from the exclusion list
    alternatives=$(cat ~/.config/yandex-disk/config.cfg | grep exclude | awk -F = '{print $2}' | sed 's/"//g' | sed 's/,/ /g' | xargs -n1 | nl )
    alternatives=$(printf '%s\n'  "${alternatives[@]}")
    
    #Gets the line number of the exclude enttry
    line=$(cat $yandex_config | nl | grep "exclude" | awk '{print $1}')
    
    #Asks you which folder to remove
    read -p "choose what you want to change 
    $alternatives :" remove
    
    clear
    
    #Converts the number you did answer to the correct string  
    remove_new=$(printf '%s\n' "${alternatives[@]}" | grep $remove | awk '{print $2}')
    
    sed -i "s|$remove_new||g" $yandex_config  
   
    #Gets the last item in the exclusion lists so it can fix some errors if needed
    #Will only be needed if you choose to remove the last folder in the list
    last=$(cat $yandex_config | grep exclude | awk -F = '{print $2}' | sed 's/"//g' | sed 's/,/ /g' | xargs -n1 )
    last=$(echo $last | awk '{print $NF}')
   
    #This will fix the file if there is 2 commas after each other 
    sed -i 's/,,/,/g' $yandex_config
    #Fixes some errors if needed, this will only occur if you     
    #remove the first or last folder in the list
    sed -i 's/=",/="/' $yandex_config 
    sed -i "s|$last,|$last|g" $yandex_config

fi
