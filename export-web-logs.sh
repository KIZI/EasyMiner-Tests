#!/bin/bash
exportToDirectory=./WebLogs
mkdir -p $exportToDirectory
docker cp easyminer-frontend:/var/www/html/easyminercenter/log /tmp/$TRAVIS_COMMIT
zip -r $exportToDirectory/$TRAVIS_COMMIT.zip /tmp/$TRAVIS_COMMIT



