#!/bin/bash
#Starts EasyMiner
docker-compose pull
docker-compose up -d easyminer-backend && \
echo EasyMiner is available at http://"$(docker-machine ip)":8894