#!/bin/bash


runningcontainers=$(docker ps -a | awk '$9 NAMES' | awk '{print $NF}')


unitlocation='/etc/systemd/system/docker-'

for rc in $runningcontainers ; do

	if  [ -e $unitlocation$rc.service ]  ;
	then
		echo "container $rc doesn't need to be removed"
	else 
		echo "Removing container $rc"
		
	docker rm -f $rc

	fi

done
