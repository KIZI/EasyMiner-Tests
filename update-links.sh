#!/bin/bash
HISTORYLENGHT=50
#<th>Branch</th><th>Commit</th><th>Commit message</th><th>Test result</th><th>Test report</th>
# Add link to report to the table
echo  "<tr>   <td><a href=\"https://github.com/$TRAVIS_REPO_SLUG.git#$TRAVIS_BRANCH\" title=\"See the repository on GitHub\" >$(echo $TRAVIS_REPO_SLUG | cut -d / -f2)</a></td> <td>$TRAVIS_BRANCH</td>    <td><a href=\"https://github.com/$TRAVIS_REPO_SLUG/commit/$TRAVIS_COMMIT\" title=\"See the commit on GitHub\" >$(echo $TRAVIS_COMMIT |  cut -c 1-5)</a></td>    <td>$TRAVIS_COMMIT_MESSAGE</td>    <td><a href=\"https://travis-ci.org/$TRAVIS_REPO_SLUG/builds/$TRAVIS_BUILD_ID\" title=\"See the build on Travis\" ><img src=\"./Resources/$TRAVIS_TEST_RESULT.svg\" /></a></td>    <td style=\"width: 10%;\"><a href=\"./TestResults/$TRAVIS_COMMIT/report.html\">Show report</a></td> <td style=\"width: 12%;\"><a href=\"./WebLogs/EasyMiner-Web-Log-$TRAVIS_COMMIT.zip\">Download log</a></td></tr>" >> links.html
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
