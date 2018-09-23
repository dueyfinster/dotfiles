#!/usr/bin/env bash
# A collection of Work aliases and commands
COMP=`hostname`

# Test if we're on a work machine
if [[ "$COMP" != "elx"* ]]
then
  return 0
fi

export http_proxy="http://www-proxy.ericsson.se:8080/"
export https_proxy="http://www-proxy.ericsson.se:8080/"
export ftp_proxy="http://www-proxy.ericsson.se:8080/"

REPOS_HOME="${HOME}/repos"

repo_folders=("$REPOS_HOME"/*)
repo_folders+=("$OTHER_REPOS"/*)
for dir in "${repo_folders[@]}";
do
  FOLDER_NAME=$(basename $dir)
  alias "$FOLDER_NAME"="cd $dir"
done

#
# REPO Commands
#
# alias rep_reset_ap="find "$REPOS_HOME"/ap* -maxdepth 1 -type d -name .git -execdir git fetch origin \; -execdir git checkout master \; -execdir git reset --hard origin/master \;"
# alias rep_reset_all="find "$REPOS_HOME"/* -maxdepth 1 -type d -name .git -execdir git checkout master \; -execdir git reset --hard origin/master \;"

# alias rep_update_all="find "$REPOS_HOME"/* -maxdepth 1 -type d -name .git -execdir git com \; -execdir git rebase origin/master \;"
# alias rep_update_ap="find "$REPOS_HOME"/ap* -maxdepth 1 -type d -name .git -execdir git checkout master \; -execdir git rebase origin/master \;"
# alias killjboss="ps -ef | grep java | grep -v grep | grep jboss | awk '{print $2}' | xargs kill -9"

copy_rpms(){
  find . -name '*.rpm' -exec cp {} $1 \;
}
