#!/bin/bash
# removes all docker containers, images, and volumes
docker rm $(docker ps -a -q)
docker rmi -f $(docker images -q)
docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
