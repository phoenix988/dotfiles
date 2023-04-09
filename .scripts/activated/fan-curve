#!/bin/bash

while true ; do

temp_card=$(nvidia-smi | grep "[1-9][1-9]C" | awk '{print $3}' | cut -d C -f 1  )

temp1="40"
temp2="50"
temp3="55"
temp4="60"
temp5="65"
temp6="70"
temp7="75"

curve1="40"
curve2="50"
curve3="70"
curve4="75"
curve5="80"
curve6="85"
curve7="90"



[ $temp_card -gt "$temp1" ] && $HOME/.scripts/activated/fan-control.sh set $curve1 &> /dev/null

[ $temp_card -gt "$temp2" ] && $HOME/.scripts/activated/fan-control.sh set $curve2 &> /dev/null

[ $temp_card -gt "$temp3" ] && $HOME/.scripts/activated/fan-control.sh set $curve3 &> /dev/null

[ $temp_card -gt "$temp4" ] && $HOME/.scripts/activated/fan-control.sh set $curve4 &> /dev/null

[ $temp_card -gt "$temp5" ] && $HOME/.scripts/activated/fan-control.sh set $curve5 &> /dev/null

[ $temp_card -gt "$temp6" ] && $HOME/.scripts/activated/fan-control.sh set $curve6 &> /dev/null

[ $temp_card -gt "$temp7" ] && $HOME/.scripts/activated/fan-control.sh set $curve7 &> /dev/null


done
