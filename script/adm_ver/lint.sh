#!/bin/sh

cd "$(dirname "$0")/.."

export files="$(git diff $(git merge-base upstream/dev HEAD) --diff-filter=d --name-only | grep -e '\.py$')"
echo '================================================='
echo '=                FILES CHANGED                  ='
echo '================================================='
if [ -z "$files" ] ; then
  echo "No python file changed. Rather use: tox -e lint\n"
  exit
fi
printf "%s\n" $files
echo "================"
echo "LINT with flake8"
echo "================"
pre-commit run flake8 --files $files
echo "================"
echo "LINT with pylint"
echo "================"
pylint_files=$(echo "$files" | grep -v '^tests.*')
if [ -z "$pylint_files" ] ; then
  echo "Only test files changed. Skipping\n"
  exit
fi
pylint $pylint_files
echo
