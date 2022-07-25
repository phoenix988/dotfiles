#!/usr/bin/fish

#This script will make sure none of my critical vms is paused
#If some of them are this will start them again


set important "phoe-03" "phoe-02" "phoe-01" "router"


set pausedvm ( virsh list | awk ' $3 == "paused" {print $2}'   )

for pvm in $pausedvm 


    virsh resume $pvm &> /dev/null 

end 


for im in $important  


    virsh list --name  | grep $im > /dev/null
  
    [ $status != "0" ] && virsh start $im > /dev/null

end
