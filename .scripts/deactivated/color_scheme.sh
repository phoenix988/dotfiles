#!/bin/bash

replace=$(sed -n /start_color/,/end_color/p ~/.config/qtile/themes/exper-config.py | sed -e s/#start_color//g \
-e s/#end_color//g -e /^$/d )
line_1=$(echo $replace | head -n1) 
echo $line_1
