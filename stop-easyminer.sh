#!/bin/bash
#Stops and deletes all Easyminer containers
docker stop easyminer-mysql
docker stop easyminer-frontend
docker stop easyminer-backend
docker stop easyminer-scorer
docker rm easyminer-mysql
docker rm easyminer-frontend
docker rm easyminer-backend
docker rm easyminer-scorer