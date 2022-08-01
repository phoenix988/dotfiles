#!/usr/bin/fish



set cron_jobs (ls /var/spool/cron/ ) 
set bak_jobs (ls /mnt/autofs/backup/cronjob/) 

set bak_path "/mnt/autofs/backup/cronjob/"
set cron_path "/var/spool/cron/"


for cron in $cron_jobs 
    


    for bak in $bak_jobs

if [ $cron = $bak ] 


    

set cron_date (ll $cron_path | grep $cron | awk '{print $6 "-" $7 "-" $8 }' | grep -v ^-) 
set bak_date (ll $bak_path | grep $bak | awk '{print $6 "-" $7 "-" $8 }' | grep -v ^-) 


 [ "$cron_date" = "$bak_date" ] ||  rsync -avh $cron_path  $bak_path 

end




end 

end 






