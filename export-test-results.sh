#!/bin/bash
exportToDirectory=./TestResults/$TRAVIS_COMMIT
mkdir -p ./TestResults/
docker cp easyminer-web-ui-tests:/TestResults/ $exportToDirectory
