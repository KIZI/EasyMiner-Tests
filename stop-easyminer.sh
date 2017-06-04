#!/bin/bash
#Stops and deletes all Easyminer containers
docker stop easyminer-mysql 2>/dev/null     
docker stop easyminer-frontend 2>/dev/null
docker stop easyminer-backend 2>/dev/null
docker stop easyminer-scorer 2>/dev/null
docker rm easyminer-mysql 2>/dev/null
docker rm easyminer-frontend 2>/dev/null
docker rm easyminer-backend 2>/dev/null
docker rm easyminer-scorer 2>/dev/null