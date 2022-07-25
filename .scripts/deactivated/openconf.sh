#!/usr/bin/fish


#configure the paths to your config files here
set files_to_edit ( sed -n '/declare/,/declare/p' ~/.dmenu/dmenueditconfig | cut -d# -f 1 | grep HOME | sed -e 's/"//g' -e 's/$HOME/\/home\/karl/g' | cut -d / -f "2 3 4 5 6 7 8" | sed 's/^/\//g'    ) 


#gives all files a number
set list (echo $files_to_edit | xargs -n 1 | nl ) 




set makethelist ""

#starts a for loop that will list the options for you
for l in $list

    set numberoflines (echo $l  | awk '{print $1}')
    set filename (echo $l  | awk '{print $2}' | sed "s/\/home\/karl\///g" ) 


    set makethelist ( echo "$makethelist [$numberoflines]$filename" | xargs -n 1 )

end

set makethelist_new ( echo $makethelist | xargs -n 1 ) 
   

read -P "Which file do you want to use? 
$makethelist_new :"  -a filetouse 

clear
[ -z $filetouse  ] && exit


for l in $list 

    set checkname ( echo $l | awk '{print $1 }' )

 [ $checkname != $filetouse ] || set thisisnotvalid "valid"


end

  [ "$thisisnotvalid" = "valid" ] || echo "not valid"  




#This loop will make sure it will only redirect the filepath to the text editor
#and not the line number 
for l in $list


    set matchingfile ( echo $l | grep $filetouse)
    set matchingline ( echo $matchingfile | awk '{print $1}')  
    set makecorrectname ( echo $matchingfile | awk '{print $2}' ) 


    


     [ "$matchingline" = "$filetouse" ] && break 

end
   

[ -z $makecorrectname  ] && exit

#opens the choice in the text editior you prefer
     vim $makecorrectname






 
