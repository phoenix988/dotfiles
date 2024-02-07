#!/bin/bash

DEST=$2
SOURCE=$1


function Exit() {
   printf "$1"
   exit
}

# Exit if no source is specified
if [ -z "$SOURCE" ] ; then
    Exit "No source Specified"

# Exit if no destination is specified
elif [ -z "$DEST" ] ; then
    Exit "No destination Specified"
fi

FILES=$(ls "$SOURCE")

main() {
  for file in $(printf '%s\n' "${FILES[@]}") ; do

     NO_EXTENSION=$(echo "$file" | sed 's/.mkv//g')

     HandBrakeCLI --input "$SOURCE/$file" --output "$DEST/$NO_EXTENSION.mp4" --preset "Fast 1080p30"
  
  done
}

main



