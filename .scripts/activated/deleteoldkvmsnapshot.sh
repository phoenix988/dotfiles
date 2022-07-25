#!/usr/bin/fish 


#This simple script will remove old snapshots of your virtualmachines


#Gets all the virtualmachines on your system and store it in a variable
set virtualmachines (virsh list --all | awk '{print $2}' | grep -v Name | sed -r 's/\s+//g' )    

#Starts the for loop will run this for all the vms
for VM in $virtualmachines 
  
 

#Calculates how many snapshots each vm has
set snapshots (virsh snapshot-list  --domain $VM 2> /dev/null| awk '{print $2}' | egrep -v '(^Creat|^-)' | sort | wc -w  )
        


#Starts a while loop taht will only run if you have more snapshots than 3 or whatever number you specify.
#Here you will specify how many snapshots you want to save
	while [ $snapshots -gt "1" ] 
	
        	
#Get the oldest snapshot that this script will delete
		set rmsnap (virsh snapshot-list --domain $VM  --topological | awk '{print $1}' | egrep -v '(^Name|^-)' | head -n1  )
		virsh snapshot-delete --domain  $VM  $rmsnap > /dev/null

            echo "Deleting snapshot $rmsnap for $VM" 

              set snapshots (math $snapshots - 1)

		end 
	
end


