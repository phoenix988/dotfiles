#!/bin/bash

compare_with="$HOME/.dmenu $HOME/.scripts/activated $HOME/.scripts/deactivated"
compare_to="$HOME/Yandex.Disk/Scripts/dmenu $HOME/Yandex.Disk/Scripts/deactivated $HOME/Yandex.Disk/Scripts/activated"
files_path="$HOME/Documents/diff-log"

for c_with in $compare_with ; do
for c_to in $compare_to ; do


$HOME/.scripts/activated/custom-diff.sh $c_with $c_to

done
done

backup_files=$(ls $files_path)




