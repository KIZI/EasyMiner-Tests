#!/bin/bash
HISTORYLENGHT=10
#<th>Branch</th><th>Commit</th><th>Commit message</th><th>Test result</th><th>Test report</th>
# Add link to report to the table
echo  "<tr><td>$TRAVIS_BRANCH</td><td>$(echo $TRAVIS_COMMIT |  cut -c 1-5)</td><td>$TRAVIS_COMMIT_MESSAGE</td><td><img src=\"./Resources/$TRAVIS_TEST_RESULT.svg\" /></td><td><a href="./TestResults/$TRAVIS_COMMIT/report.html">Test report</a></td></tr>" >> links.html
# Add commit to history of commits
echo $TRAVIS_COMMIT >> commit-history.txt
# Preserve only $HISTORYLENGHT reports
echo "$(tail -$HISTORYLENGHT commit-history.txt)" > commit-history.txt
echo "$(tail -$HISTORYLENGHT links.html)" > links.html
#Delete old reports
cd TestResults
ls -d */ | cut -f1 -d'/' > tmp
cat ../commit-history.txt >> tmp
echo "$(cat tmp | sort | uniq -u)" > tmp
xargs rm -rf < tmp
rm tmp
