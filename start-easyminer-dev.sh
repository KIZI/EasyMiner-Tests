#!/bin/bash
version=${1:-v2.4} # v2.4 is current stable latest
branch=${2:-master}
./stop-easyminer.sh
./pull-easyminer-images-github.sh $version $branch
./run-easyminer-images.sh $version