#!/bin/bash
#Starts EasyMiner
docker-compose pull
docker-compose up --force-recreate -d easyminer && \
echo EasyMiner is available at http://"$(docker-machine ip)":8894