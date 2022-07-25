#!/usr/bin/fish


set directory "$HOME/.dmenu/" 

set files ( ls $directory )


for file in $files

echo $file



end




