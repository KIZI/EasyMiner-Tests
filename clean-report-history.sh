#!/bin/bash
#Remove all reports from repository and regenerates main page.
> links.html
> commit-history.txt
rm -rf ./TestResults/*
rm -rf ./WebLogs/*
./update-index-page.sh
echo "All test reports has been removed"