GH_PAGES_REPO=$(echo $TRAVIS_REPO_SLUG | cut -d / -f1)
git clone -b gh-pages --single-branch https://github.com/$GH_PAGES_REPO/EasyMiner-Tests.git gh-pages
cd gh-pages
./export-test-results.sh
./export-web-logs.sh
./update-links.sh
./update-index-page.sh
git add .
git -c user.name='TravisCI' -c user.email='travis' commit -m "Travis build result ($TRAVIS_REPO_SLUG-$(echo $TRAVIS_COMMIT |  cut -c 1-5))"
git remote set-url origin git@github.com:$GH_PAGES_REPO/EasyMiner-Tests.git
git push
