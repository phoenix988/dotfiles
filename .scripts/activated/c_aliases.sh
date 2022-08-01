#!/bin/bash

list="$HOME/Documents/alias.list"

shell_alias_paths="$HOME/.config/oh-my-zsh/aliases.sh  $HOME/.config/bash/aliases.sh  $HOME/.config/fish/conf.d/aliases.fish"

for sap in $shell_alias_paths ; do 
    
    dir=$(echo $sap | sed 's/\/aliases.*//g')

    [ -d $dir  ] || echo "Path $sap doesn't exist .... exiting " 
    [ -d $dir  ] || break
    

    check_sh=$(echo $sap | awk -F / '/.*/ { print $NF }')     
     
     [ $check_sh = "aliases.fish" ] && cat $list | sed 's/#!\/bin\/bash//g' > $sap   
     [ $check_sh = "aliases.sh" ]  && echo "#!/bin/bash" > $sap && cat $list | sed 's/#!\/bin\/bash//g' >> $sap
      
  done


