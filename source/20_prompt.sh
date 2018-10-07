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

function parse_git_deleted(){
  deleted=$(git status -s | egrep "^D" | wc -l | xargs)
  [[ $deleted != "0" ]] && echo -n " ${red}✖ ${deleted}${reset}"
}

function parse_git_staged(){
  staged=$(git status -s | egrep "^M|^A" | wc -l | xargs)
  [[ $staged != "0" ]] && echo -n " ${purple}●${staged}${reset}"
}

function parse_git_modified(){
  modified=$(git status -s | egrep "^ M" | wc -l | xargs)
  [[ $modified != "0" ]] && echo -n " ${blue}✚ ${modified}${reset}"
}

function parse_git_untracked(){
  untracked=$(git status -s | egrep "^\?\?" | wc -l | xargs)
  [[ $untracked != "0" ]] && echo -n " ${white}…${untracked}${reset}"
}

function parse_git_dirty {
  status=$(git status --porcelain -b 2> /dev/null)
  aheadRegex="ahead ([0-9]+)"
  behindRegex="behind ([0-9]+)"

  [[ $status =~ $aheadRegex ]] && ahead="${BASH_REMATCH[1]}" || ahead="0"
  [[ $status =~ $behindRegex ]] && behind="${BASH_REMATCH[1]}" || behind="0"

  [[ $(git status --long 2> /dev/null | tail -n1) == "nothing to commit, working tree clean" ]] && echo -n " ${green}✔${reset}"
  [[ $ahead != "0" ]] && echo -n " ${yellow}↑${ahead}${reset}"
  [[ $behind != "0" ]] && echo -n " ${yellow}↓${behind}${reset}"
}

function parse_git_stash {
  stash_count=$(git stash list 2> /dev/null | wc -l | xargs)
  [[ ${stash_count} -gt 0 ]] && echo " ⚑$stash_count"
}

function parse_git_branch {
  BNAME=$(git branch | grep \* | cut -d ' ' -f2)
  echo -n "$BNAME"
}

function git_status {
  if [[ $(which git) ]]; then
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) ]]; then
      echo -n " ($(parse_git_branch)$(parse_git_dirty)$(parse_git_staged)$(parse_git_deleted)$(parse_git_modified)$(parse_git_untracked)$(parse_git_stash))";
    fi
  fi
}

function get_return_code {
  [[ $1 != 0 ]] && export RET_CODE="\(${bold}${red}$1${reset}) "
}

function get_hostname {
  export SHORTNAME=${HOSTNAME%%.*}
}

function user_color {
  if [[ "$SSH_TTY" ]]; then
    # connected via ssh
    usercolor=$cyan;
  elif [[ "$USER" == "root" ]]; then
    # logged in as root
    usercolor=$bold$red;
	else
    usercolor=$orange;
  fi
}

function settitle() {
  u=${USERNAME}
  h="$u@${HOSTNAME}"
  echo -ne "\e]2;$h\a\e]1;$h\a";
}
__prompt_command() {
  local ex_code="$?"
  RET_CODE="" # Res
  get_return_code "${ex_code}"; settitle; get_hostname; history -a;

  # Set prompt and window title
  inputcolor=$white
  cwdcolor=$green
  host_name=$yellow
  user_color
  PS1='\e\[${RET_CODE}\]\e\[${usercolor}\]\u\[${reset}\]@\e\[${host_name}\]\[${SHORTNAME}\]:\e\[${cwdcolor}\]\[$PWD\]\e\[${reset}\]\[$(git_status)\]\n\A $ \[${inputcolor}\]\[${reset}\]'
}


PROMPT_COMMAND='__prompt_command'
