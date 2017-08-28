#!/bin/bash
#Creates network and run EasyMiner containers in it
docker network rm easyminer
docker network create easyminer
docker-compose pull
docker-compose up -d
echo EasyMiner is available at http://"$(docker-machine ip)":8894