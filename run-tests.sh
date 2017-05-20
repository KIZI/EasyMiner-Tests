#!/bin/bash
#Restarts docker image with tests and starts test execution
docker stop easyminer-web-ui-tests
docker rm easyminer-web-ui-tests
docker create --privileged --network=easyminer --name=easyminer-web-ui-tests -e ROBOT_TESTS=/Tests/ soulekamil/robotframework-ff
docker cp ./Tests/ easyminer-web-ui-tests:/Tests/
docker start -i easyminer-web-ui-tests