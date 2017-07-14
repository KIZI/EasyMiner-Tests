#!/bin/bash
#Exports Easyminer Center logs to specified directory
#Usage: export-test-results.sh "export-directory"
#where:
#    export-directory    Destination directory for export
exportToDirectory=${1:-./WebLogs}
mkdir -p $exportToDirectory
ExportPath=$exportToDirectory/WebLog-`date +%Y-%m-%d-%H_%M_%S`
docker cp easyminer-frontend:/var/www/html/easyminercenter/log $ExportPath
echo "Web log was exported to directory $ExportPath "
