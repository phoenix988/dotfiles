#!/bin/bash

echo "Welcome to my script that will help you to copy file using utilities like rsync or scp"
echo "Type ? if you need help"


while true; do
	 read -p "What utility do you wish to use [? for help]?: " utility
	  case $utility in 
		  [Ss]* )

read -p "What file do you want to copy : " file

read -p "Where do you want to copy this file : " location

scp  $file $location;;
                 [Rr]* )   
			 
read -p "What file or folder do you want to copy, remote or local file: " file 

read -p "where do you want to copy this file or folder: " location
			 
		rsync -r $file $location 	 
			 
			 
			 ;;
		 [?]* ) echo "S = scp"
			echo "R = rsync" 
			echo "E = exit"
			
			echo "valid syntax is user@remoteserver:/folder/file";;
		[Ee]* ) exit;; 
		* ) echo "Not a valid argument, ? for help: " ;;

	 esac
     done	 


