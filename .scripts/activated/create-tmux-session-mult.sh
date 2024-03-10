#!/bin/bash

# This script will create a new tmux session for me 
# so all my windows are ready to go after every reboot 

#choose the name of your sessions here
declare -a sessions=(
    "python"
    "lua"
    "bash"
    "config"
    "ssh"
)


for ses in $(printf '%s\n' "${sessions[@]}") ; do
    tmux has-session -t "$ses" &> /dev/null
    if [ "$status" != 0 ] ; then
        tmux new-session -s $ses  
    fi

done

 tmux attach 

