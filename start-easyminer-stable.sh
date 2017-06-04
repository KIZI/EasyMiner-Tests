#!/bin/bash
version=${1:-2.4} # v2.4 is current stable latest
branch=${2:-master}
./stop-easyminer.sh
./pull-easyminer-images-dockerhub.sh $version
./run-easyminer-images.sh $version