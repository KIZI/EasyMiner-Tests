#!/bin/bash
#Recreates docker containers for tests and starts test execution
docker-compose pull
docker-compose -v down
docker-compose down
docker-compose up --exit-code-from easyminer-tests --force-recreate easyminer-tests