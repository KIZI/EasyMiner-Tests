# Introduction
This repository contains web UI tests for [EasyMiner project](http://easyminer.eu).
Tests are written in [Robot Framework](http://robotframework.org/). Test suite can be executed using provided docker image, that supports testing against Firefox and Xvfb. 

[![Build Status](https://travis-ci.org/soulekamil/EasyMiner-WebUITests.png)](https://travis-ci.org/soulekamil/EasyMiner-WebUITests)

# How to execute tests locally
## Requirements
- Docker 1.12+ 
- Bash shell - for Windows users: MinGW (shipped with Git for Windows or standalone) is sufficient
## Test execution
To run tests locally follow these steps:
- Start EasyMiner locally (web is available at *http://\<docker-machine ip\>:8894*)
```
 ./start-easyminer.sh 
```
- Run tests - execute script
```
./run-tests.sh
```
- [Optional] Export html report from of latest test run to local
```
 ./export-test-results.sh 
```
- Clean up tests 
```
 ./cleanup-tests.sh 
```
- Stop local instance of EasyMiner
```
 ./stop-easyminer.sh 
```

# How to add and edit tests
Robot framework tests can be edited via plugins for common IDEs or standalone editor, all available [here](http://robotframework.org/#tools-editors).<br />
All tests have to:
- Be added to /Test directory
- Use only Firefox as browser<br />


Provided docker container for test execution enables
- Using mysql client tools for easy DB access
- Using bash scripts (because test are executed in [Alpine Linux](https://hub.docker.com/r/gliderlabs/alpine/) based container)

# Notes
Since this is in development as part of individual school project, pull requests won't be accepted.


Current version is in still in development and test suite will contain more test cases in near future.