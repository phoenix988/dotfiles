#!/bin/bash


numberofscreens=$(xrandr | grep -v disconnected | grep connected | awk '{print $1}' | wc -l)

 [ $numberofscreens -gt "1" ] && $HOME/.screenlayout/layout.sh || $HOME/.screenlayout/single.sh






