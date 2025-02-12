#!/bin/bash
STATUS="$(git status)"

if [[ $STATUS == *"nothing to commit, working tree clean"* ]]
then
  sed -i '/.output/d' ./.gitignore
  bun generate
  git add .
  git commit -m "Update dist"
  git push origin `git subtree split --prefix .output/public main`:refs/heads/gh-pages --force
  git reset HEAD~
  git checkout .gitignore
else
    echo "Need clean working directory to publish"
fi
