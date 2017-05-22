git clone -b gh-pages --single-branch https://github.com/soulekamil/EasyMiner-WebUITests.git gh-pages
cd gh-pages
exportToDirectory=./TestResults/$TRAVIS_COMMIT
mkdir -p ./TestResults
docker ps
docker cp easyminer-web-ui-tests:/TestResults/ $exportToDirectory
ls $exportToDirectory
./update-links.sh
./update-index-page.sh
git add .
git -c user.name='TravisCI' -c user.email='travis' commit -m "Autoupdate test result for $TRAVIS_BRANCH-$TRAVIS_COMMIT-$TRAVIS_COMMIT_MESSAGE"
git remote set-url origin git@github.com:soulekamil/EasyMiner-WebUITests.git
git push
