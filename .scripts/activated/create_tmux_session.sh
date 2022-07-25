#!/usr/bin/fish


#This script will create a new tmux session for me 
#so all my windows are ready to go after every reboot 

#choose the name of your session here
set sessionname "karl"
tmux has-session -t $sessionname &> /dev/null

if [ $status != 0 ]
    tmux new-session -s $sessionname -n localhost -d 
    tmux new-window -t $sessionname -n Vim  
    tmux new-window -t $sessionname -n mutt  
    tmux new-window -t $sessionname -n phoe01 
    tmux send-keys -t $sessionname:Vim 'vim'  C-m
    tmux send-keys -t $sessionname:mutt 'mutt'  C-m
    tmux send-keys -t $sessionname:phoe01 'phoe01'  C-m
    tmux new-window -t $sessionname -n phoe02 
    tmux send-keys -t $sessionname:phoe02 'phoe02'  C-m
    tmux new-window -t $sessionname -n phoe04 
    tmux send-keys -t $sessionname:phoe03 'phoe04'  C-m
    #tmux splitw -h -t localhost 
    tmux select-window -t $sessionname:localhost
end 


 tmux attach -t $sessionname

