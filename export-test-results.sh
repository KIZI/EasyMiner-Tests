#!/bin/bash
exportToDirectory=./TestResults/$TRAVIS_COMMIT
mkdir -p ./TestResults/
docker cp easyminer-frontend:/TestResults/ $exportToDirectory