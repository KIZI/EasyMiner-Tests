#!/bin/bash
exportToDirectory=./WebLogs
mkdir -p $exportToDirectory
docker cp easyminer-frontend:/var/www/html/easyminercenter/log /tmp/$TRAVIS_COMMIT
zip -r  /tmp/$TRAVIS_COMMIT.zip /tmp/$TRAVIS_COMMIT
cp /tmp/$TRAVIS_COMMIT.zip $exportToDirectory/$TRAVIS_COMMIT.zip

