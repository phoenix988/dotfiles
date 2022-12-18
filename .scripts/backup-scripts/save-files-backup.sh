#!/bin/bash

date_for_backup=$(date +%d-%h-%Y-%H-%M )  

declare -A games_backup

games_backup[cyberpunk2077]="$HOME/.steam/debian-installation/steamapps/compatdata/4124252510/pfx/drive_c/users/steamuser/"

game_name=$(printf '%s\n' "${!games_backup[@]}")

for g_name in $(printf '%s\n' "${game_name[@]}") ; do


game_path=$(printf '%s\n' "${games_backup[${g_name}]}")


[ -d $HOME/Yandex.Disk/saved-games/$g_name ] || mkdir -p $HOME/Yandex.Disk/saved-games/$g_name


tar --use-compress-program="pigz -7" -g $HOME/Yandex.Disk/saved-games/$g_name/$g_name.snar \
    -c $game_path -f $HOME/Yandex.Disk/saved-games/$g_name/$g_name-$date_for_backup.tgz


done
