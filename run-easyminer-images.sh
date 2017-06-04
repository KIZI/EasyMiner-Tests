#!/bin/bash
version=${1:-v2.4} # v2.4 is current stable
#Create network and run containers in it
docker network rm easyminer
docker network create easyminer
docker run --name easyminer-mysql -e MYSQL_ROOT_PASSWORD=root --network easyminer -d mariadb:10
#Short sleep to make sure that DB is inicialized before starting Easyminer
sleep 40
docker run -d -p 8894:80 --name easyminer-frontend --network easyminer kizi/easyminer-frontend:$version
docker run -d -p 8893:8893 -p 8891:8891 -p 8892:8892 --name easyminer-backend -e EM_USER_ENDPOINT=http://easyminer-frontend/easyminercenter --network easyminer kizi/easyminer-backend:$version
docker run -d -p 8080:8080 --name easyminer-scorer --network easyminer kizi/easyminer-scorer:$version
#Short sleep to make sure that Easyminer is inicialized
sleep 45
echo EasyMiner is available at http://"$(docker-machine ip)":8894
