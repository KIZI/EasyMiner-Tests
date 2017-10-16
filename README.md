# Introduction
![Build Status](https://travis-ci.org/KIZI/EasyMiner-Tests.svg?branch=master)
**Additional build results info available [here](https://kizi.github.io/EasyMiner-Tests/)**

This repository contains web UI tests for [EasyMiner project](http://easyminer.eu).
Tests are written in [Robot Framework](http://robotframework.org/).
Test suite can be executed using provided docker image.
Tests are performed against Firefox browser, using Xvfb as an in-memory display.

# How to execute tests locally
## Requirements
- [Docker 1.12+](https://docs.docker.com/engine/installation/)
- [Docker Compose 1.12+](https://docs.docker.com/compose/install/#prerequisites)
- Bash shell - for Windows users: MinGW (shipped with Git for Windows or standalone) is sufficient
## Test execution
To run tests locally follow these steps:
- Run tests - execute script:
```
./run-tests.sh
```
This script will start EasyMiner and run tests in Docker container. Test results are exported to folder TestResults, that is shared with Docker (via Docker volume). After test execution ends, EasyMiner system is still running (to allow easier investigation of possible test failures).

EasyMiner GUI is available at http://'docker-machine':8894/easyminercenter , where 'docker-machine' is address of used docker machine

If you want to use local Easyminer Docker images, simply change sources for services in docker-compose.yml

- [Optional] Export logs from web application for easier debugging. Exports are available at WebLogs folder.
```
 ./export-web-logs.sh
```
- Clean up tests - stop all associated services using this script:
```
 ./cleanup-tests.sh 
```
## Starting Easyminer
Easyminer can be started separately without test execution via script (GUI available at http://'docker-machine':8894/easyminercenter):
```
 ./start-easyminer.sh 
```
- To stop local instance of EasyMiner use:
```
 ./stop-easyminer.sh 
```

# How to add and edit tests
Robot framework tests can be edited via plugins for common IDEs or standalone editor, all available [here](http://robotframework.org/#tools-editors).<br />
All tests have to follow conventions described [here](HowToWriteTests.md).
