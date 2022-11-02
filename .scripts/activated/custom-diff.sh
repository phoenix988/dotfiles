#!/bin/bash

#Script that will compare 2 folders files with each other
#Useful if you want to know what have been updated since your last backup
#Only works if the file has the same name otherwise this script isn't gonna compare them

#The folders that you will compare
check=$(ls $1)
foldercomp=$(ls $2)

#The path of the output of this script so you can easily 
#access the result. If the files are identical it will not generate any output
diff_log_path="$HOME/Documents/diff-log"
date_log=$( date +%d%m%Y-%H%M )

for ch in $(echo $check | xargs -n1) ; do
for comp in $(echo $foldercomp | xargs -n1) ; do

    rm_dir=$(ls -lh $1/$ch | grep ^d | awk '{print $NF}')
    
    if [ -z $rm_dir ] ; then     
    echo "" &> /dev/null
    else
     break   
    fi


    if [ "$ch" = "$comp" ] ; then
        
        empty=$(diff $1/$ch $2/$comp)

        
        if [ -z "$empty" ] ; then 
            
            echo "" &> /dev/null

        else
            
            [ -d "$diff_log_path/$ch" ] || mkdir -p $diff_log_path/$ch
        
            diff $1/$ch $2/$comp > $diff_log_path/$ch/$ch-$date_log 2> /dev/null
        fi

    fi

done

done









