#!/usr/bin/fish

set sessionname "htop"

tmux has-session -t $sessionname &> /dev/null


if [ $status != 0 ]
   
    tmux new-session -s $sessionname -n htop -d 

    tmux send-keys -t $sessionname:htop 'htop'  C-m
 end


 tmux attach -t $sessionname
 


