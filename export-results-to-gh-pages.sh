git clone -b gh-pages --single-branch https://github.com/soulekamil/EasyMiner-WebUITests.git gh-pages
cd gh-pages
./export-test-results.sh
./update-links.sh
./update-index-page.sh
git add .
git -c user.name='TravisCI' -c user.email='travis' commit -m "Autoupdate test result for $TRAVIS_BRANCH-$TRAVIS_COMMIT-$TRAVIS_COMMIT_MESSAGE"
git push -f -q https://soulekamil:${GH_TOKEN}@github.com/soulekamil/EasyMiner-WebUITests.git gh-pages &2>/dev/null
