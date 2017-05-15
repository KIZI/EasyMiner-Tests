#!/bin/bash
#Exports Easyminer test results to specified directory
#Usage: export-test-results.sh "export-directory"
#where:
#    export-directory    Destination directory for export
exportToDirectory=${1:-./TestResults}
mkdir -p $exportToDirectory
docker cp easyminer-web-ui-tests:/TestResults/ $exportToDirectory/TestResults-`date +%Y-%m-%d-%H_%M_%S`
