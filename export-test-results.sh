#!/bin/bash
exportToDirectory=./TestResults/$TRAVIS_COMMIT
mkdir -p $exportToDirectory
cp -R ../TestResults/TestResults-*/* $exportToDirectory