# Introduction
![Build Status](https://travis-ci.org/KIZI/EasyMiner-Tests.svg?branch=master)

This repository contains web UI tests for [EasyMiner project](http://easyminer.eu).
Tests are written in [Robot Framework](http://robotframework.org/).
Test suite can be executed using provided docker image.
Tests are performed against Firefox browser.
Xvfb as an in-memory display.

**Additional build results info available [here](https://kizi.github.io/EasyMiner-Tests/)**
# How to execute tests locally
## Requirements
- [Docker 1.12+](https://docs.docker.com/engine/installation/)
- [Docker Compose 1.12+](https://docs.docker.com/compose/install/#prerequisites)
- Bash shell - for Windows users: MinGW (shipped with Git for Windows or standalone) is sufficient
## Test execution
To run tests locally follow these steps:
- Run tests - execute script. This script will start EasyMiner and run tests in Docker container.
Test results are exported to folder TestResults, that is shared with Docker (via Docker volume).
After test execution ends, EasyMiner system is still running (to allow easier investigation of possible test failures).
If you want to use local Easyminer Docker images, change sources for services in docker-compose.yml
```
./run-tests.sh
```
- [Optional] Export logs from web application for easier debugging.
```
 ./export-web-logs.sh
```
- Clean up tests
```
 ./cleanup-tests.sh 
```
## Starting Easyminer
Easyminer can be started separately without test execution via script:
```
 ./start-easyminer.sh 
```
- To stop local instance of EasyMiner use:
```
 ./stop-easyminer.sh 
```

# How to add and edit tests
Robot framework tests can be edited via plugins for common IDEs or standalone editor, all available [here](http://robotframework.org/#tools-editors).<br />
All tests have to:
- Be added to /Test directory
- Use only Firefox as browser<br />

Provided docker container for test execution enables
- Using bash scripts (because test are executed in [Alpine Linux](https://hub.docker.com/r/gliderlabs/alpine/) based container)

# Notes
Since this is in develoment as part of individual school project, pull requests won't be accepted.