#!/bin/sh

cd "$(dirname "$0")/.."

head -n 5 homeassistant/const.py | tail -n 1 | grep PATCH_VERSION > /dev/null

if [ $? -eq 1 ]
then
  echo "Patch version not found on const.py line 5"
  exit 1
fi

head -n 5 homeassistant/const.py | tail -n 1 | grep dev > /dev/null

if [ $? -eq 0 ]
then
  echo "Release version should not contain dev tag"
  exit 1
fi

CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`

if [ "$CURRENT_BRANCH" != "master" ] && [ "$CURRENT_BRANCH" != "rc" ]
then
  echo "You have to be on the master or rc branch to release."
  exit 1
fi

rm -rf dist build
python3 setup.py sdist bdist_wheel
python3 -m twine upload dist/* --skip-existing
