#!/bin/bash

#This script will create a new tmux session for me 
#so all my windows are ready to go after every reboot 

#choose the name of your session here
sessionname="karl"
tmux has-session -t $sessionname &> /dev/null

if [ $status != 0 ] ; then
    tmux new-session -s $sessionname -n localhost -d 
    tmux new-window -t $sessionname -n Vim  
    tmux new-window -t $sessionname -n mutt  
    tmux new-window -t $sessionname -n music  
    tmux send-keys -t $sessionname:Vim 'vim'  C-m
    tmux send-keys -t $sessionname:mutt 'mutt'  C-m
    tmux send-keys -t $sessionname:music 'ncspot'  C-m
    tmux select-window -t $sessionname:localhost
fi


 tmux attach -t $sessionname

