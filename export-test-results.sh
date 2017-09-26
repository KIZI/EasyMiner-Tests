#!/bin/bash
exportToDirectory=./TestResults/$TRAVIS_COMMIT
mkdir -p $exportToDirectory
docker cp easyminer-frontend:/TestResults/ $exportToDirectory