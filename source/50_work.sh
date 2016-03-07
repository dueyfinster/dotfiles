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
#export VERSANT_ROOT="/opt/versant/vjpa_server"
#export LINUX_BREW="$HOME/.linuxbrew/bin"
#PATH="$LINUX_BREW:$PATH"
PATH="$JAVA_HOME/bin:$PATH"

#OPENDJ_HOME="$HOME/repos/ap-parent/deployment/target/opendj"
#OPENDJ_BIN="$OPENDJ_HOME/bin"

#JBOSS_HOME="$HOME/repos/ap-parent/deployment/target/jboss/jboss-eap-6.2.4"
#JBOSS_BIN="$JBOSS_HOME/bin"

#VERSANT_HOME="/opt/versant/vjpa_server"
#VERSANT_BIN="$VERSANT_HOME/bin"

REPOS_HOME="${HOME}/repos"
OTHER_REPOS="${HOME}/other_repos"
#CLI_HOME="${OTHER_REPOS}/command-line-interface/CliApp"

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
alias rep_reset_ap="find "$REPOS_HOME"/ap* -maxdepth 1 -type d -name .git -execdir git fetch origin \; -execdir git checkout master \; -execdir git reset --hard origin/master \;"
alias rep_reset_all="find "$REPOS_HOME"/* -maxdepth 1 -type d -name .git -execdir git checkout master \; -execdir git reset --hard origin/master \;"

alias rep_update_all="find "$REPOS_HOME"/* -maxdepth 1 -type d -name .git -execdir git com \; -execdir git rebase origin/master \;"
alias rep_update_ap="find "$REPOS_HOME"/ap* -maxdepth 1 -type d -name .git -execdir git checkout master \; -execdir git rebase origin/master \;"

#
# BUILD & DEPLOY COMMANDS
#
alias apbuild="cd $REPOS_HOME/ap-parent && mvn clean install -Dmodules -Dsnapshot.all"
alias apdeploy="cd $REPOS_HOME/ap-parent/deployment && mvn clean install -Ddev.local -Dsnapshot.all"


alias killjboss="ps -ef | grep java | grep -v grep | grep jboss | awk '{print $2}' | xargs kill -9"
alias rwa="source $HOME/.work_aliases.sh" # reload aliases
alias cli-start="cd $CLI_HOME && cdt2 serve --proxy-config dev/js/proxy-config.json"
alias repos="cd $REPOS_HOME"
alias jboss="cd $JBOSS_HOME"
alias cli-chrome="/usr/bin/google-chrome --allow-file-access-from-files --disable-web-security -incognito --new-window http://localhost:8585/#cliapp"

copy_rpms(){
  find . -name '*.rpm' -exec cp {} $1 \;
}

#
# Test Commands

alias tafregression="cd $REPOS_HOME/ap-macro-testware && mvn clean install -Dsnapshot.all -Dsuites=APERbsRegressionSuite.xml"

rebase_ap(){
    cd $REPOS_HOME
    repos=($(find . -mindepth 1 -maxdepth 1 -type d -name 'ap*'))
    for D in ${arr[@]}; do
        cd $D;
	git rebase origin/master
        cd ..
    done
}


## Versant Commands
#db2tty -D dps_integration -i ns_ap.Pt_ERBSProject
#db2tty -D dps_integration ns_ap.Pt_ERBSProject
#db2tty -D dps_integration
#db2tty -D dps_integration > ~/Desktop/dpsdump.txt
#db2tty -D dps_integration ns_ap. > ~/Desktop/dpsdump.txt
#db2tty -D dps_integration ns_ap.* > ~/Desktop/dpsdump.txt
#db2tty -D dps_integration -i ns_ap > ~/Desktop/dpsdump.txt
#db2tty -D dps_integration -i ns_ap.* > ~/Desktop/dpsdump.txt
#db2tty -D dps_integration > ~/Desktop/dpsdump.txt
#db2tty -D dps_integration -i ns_ap.Pt_NodeArtifactContainer
#db2tty -D dps_integration -i ns_ap.Pt_NodeArtifact
