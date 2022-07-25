#!/bin/bash


movie_path="/mnt/autofs/movies/Films"
download_path="/mnt/autofs/movies/downloads/"

download_path=$(ls $download_path | grep -v "meta$")

echo $download_path
exit


for move in $download_path ; do

    for move_to in $(ls $movie_path) ; do

     printf "$move"
    done

done

