#!/bin/bash
#Exports Easyminer test results to specified directory
#Usage: export-test-results.sh "export-directory"
#where:
#    export-directory    Destination directory for export
exportToDirectory=${1:-./TestResults}
mkdir -p $exportToDirectory
ExportPath=$exportToDirectory/TestResults-`date +%Y-%m-%d-%H_%M_%S`
docker cp easyminer-web-ui-tests:/TestResults/ $ExportPath
echo "Report was exported to directory $ExportPath "
