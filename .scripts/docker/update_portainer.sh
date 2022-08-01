#/bin/bash


portainer=$(docker ps | awk '$NF == "portainer" {print $NF}')


if [ -z $portainer ] ; then 

    echo "portainer is not running in any container"

else


    docker rm -f $portainer
    
    docker pull portainer/portainer-ce 

    docker run -d -p 8000:8000 -p 9000:9000  -p 9443:9443 --name=portainer --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

fi



