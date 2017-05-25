#!/bin/bash
> links.html
> commit-history.txt
rm -rf ./TestResults/*
./update-index-page.sh
echo "All test reports has been removed"