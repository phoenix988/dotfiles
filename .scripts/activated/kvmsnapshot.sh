#!/bin/bash

#script that creates snapshots of virtual machines running in KVM

runningvm=$(virsh list | cut -d " " -f 5,6 | egrep -v '(^-|Name)' )



#if no vm is running
for run in $runningvm 

do 

if [ -z "$run" ] ; then

    echo "No vms found"

    exit
fi


done


for vm in $runningvm  

do

      date=$(date +%Y-%m-%d-%H-%M)
	
      snapshot=$(virsh snapshot-create-as --name $date --domain $vm)
     
      error=$(echo $snapshot | awk '{ print $1 }' )

if [ $error = "error" ] ; then
   
echo "failed to create snapshot"

else 
    
    echo "snapshot created for $vm"


fi 
 done


