#!/bin/bash
docker start my-jenkins
sleep 5
docker exec -u 0 -it my-jenkins chmod 666 /var/run/docker.sock
echo "Jenkins is ready and Docker permissions are set!"