#!/bin/bash
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

export SHELL=/bin/bash

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    tput sgr0 # reset colors

    bold=$(tput bold)
    reset=$(tput sgr0)

    # Solarized colors
    # (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values)
    black=$(tput setaf 0)
    blue=$(tput setaf 33)
    cyan=$(tput setaf 37)
    green=$(tput setaf 64)
    orange=$(tput setaf 166)
    purple=$(tput setaf 125)
    red=$(tput setaf 124)
    white=$(tput setaf 15)
    yellow=$(tput setaf 136)
    khaki=$(tput setaf 101)
else
    bold=""
    reset="\e[0m"

    black="\e[1;30m"
    blue="\e[1;34m"
    cyan="\e[1;36m"
    green="\e[1;32m"
    orange="\e[1;33m"
    purple="\e[1;35m"
    red="\e[1;31m"
    white="\e[1;37m"
    yellow="\e[1;33m"
fi

function get_git_branch {
  if [ -d .git ]; then
    BNAME=$(git branch | grep \* | cut -d ' ' -f2)
    BRANCH_NAME=" ($BNAME) "
  else
    BRANCH_NAME=""
  fi;

}

function get_hostname {
  export SHORTNAME=${HOSTNAME%%.*}
}

function user_color {
  id | grep "Admin" > /dev/null
  RETVAL=$?
  if [[ $RETVAL == 0 ]]; then
    usercolor=$red;
  else
    usercolor=$orange;
  fi
}

function settitle() {
  u=${USERNAME}
  h="$u@${HOSTNAME}"
  echo -ne "\e]2;$h\a\e]1;$h\a";
}

# Set prompt and window title
inputcolor=$white
cwdcolor=$green
host_name=$yellow
user_color
PROMPT_COMMAND='settitle; get_hostname; get_git_branch; history -a;'
export PS1='\e\[${usercolor}\]\u\[${reset}\]@\e\[${host_name}\]\[${SHORTNAME}\]:\e\[${cwdcolor}\]\[$PWD\]\e\[${reset}\]\[${BRANCH_NAME}\]\n\A $ \[${inputcolor}\]\[${reset}\]'

