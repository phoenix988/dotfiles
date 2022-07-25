#!/bin/bash


runningcontainers=$(docker ps | awk '$9 NAMES' | awk '{print $NF}')

unitlocation='/etc/systemd/system/docker-'


for rc in $runningcontainers; do

	if [[ -e $unitlocation$rc.service ]]; then  

	
		echo "Unit file for $rc does exist"

	else


	
echo   	"[Unit]
	Description=$rc service
	Requires=docker.service
	After=docker.service

	[Service]
	Restart=always
	ExecStart=/usr/bin/docker start -a $rc
	ExecStop=/usr/bin/docker stop -t 2 $rc

	[Install]
	WantedBy=default.target" >> $unitlocation$rc.service 
	
	systemctl daemon-reload
	systemctl start docker-$rc.service
	
	fi

done
