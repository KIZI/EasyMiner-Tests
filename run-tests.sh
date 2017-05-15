#!/bin/bash
#Builds and docker image with tests and starts test execution
docker build -t soulekamil/robot-docker .
docker stop easyminer-web-ui-tests
docker rm easyminer-web-ui-tests
docker create --privileged --network=easyminer --name=easyminer-web-ui-tests -e ROBOT_TESTS=/Tests/ soulekamil/robot-docker
echo BaseUrl=\"http://"$(docker-machine ip)":8894\" > ./Tests/Resources/variables.py
docker cp ./Tests/ easyminer-web-ui-tests:/Tests/
docker start -i easyminer-web-ui-tests