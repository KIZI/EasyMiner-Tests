#!/bin/bash
#Pulls docker images from DockerHub - i.e. latest released image for specified version
version=${1:-v2.4} # v2.4 is current stable latest
docker pull mariadb:10
docker pull kizi/easyminer-frontend:$version
docker pull kizi/easyminer-backend:$version
docker pull kizi/easyminer-scorer:$version