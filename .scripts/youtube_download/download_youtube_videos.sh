#!/usr/bin/fish 


set url_list (cat $HOME/scripts/youtube_download/url_list)

set folder "blackpink"
for list in $url_list 
  
     if [ -d /media/music/videos/$folder ]
         echo ""
     else 
         mkdir /media/music/videos/$folder
    
     end
         cd /media/music/videos/$folder
    youtube-dl $list 
end 
