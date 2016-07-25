#!/bin/bash
source ${HOME}/.dotfiles/bin/dotfiles "source"
REPOS_HOME="$HOME/repos"

array=("$REPOS_HOME"/*)
for dir in "${array[@]}";
do
  DIR_NAME=$(basename $dir)
  cd "$dir"
  git checkout master
  git fetch
  RESULT=$(git reset --hard origin/master)
  e_header "$DIR_NAME"
  if [[ $? -eq 0 ]];
  then
    e_success "$RESULT"
  else
    e_error "$RESULT"
  fi
  cd ..
done
