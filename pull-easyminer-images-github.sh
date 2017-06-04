#!/bin/bash
#Pulls docker images from GitHub - i.e. includes latest pushes for specified version
version=${1:-v2.4} # v2.4 is current stable latest
branch=${2:-master}
docker pull mariadb:10
docker build -t kizi/easyminer-frontend:$version https://github.com/KIZI/EasyMiner-EasyMinerCenter.git#$branch:/  1>/dev/null
docker pull kizi/easyminer-backend:$version 1>/dev/null #todo change this pull to build from git repo once the Dockerfile is fixed  
docker build -t kizi/easyminer-scorer:$version https://github.com/KIZI/EasyMiner-Scorer.git#$branch:/  1>/dev/null