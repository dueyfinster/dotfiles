#!/usr/bin/env bash
# Alias common directories and files

# Common Locations
alias desktop="cd ~/Desktop"
alias dropbox="cd ~/Dropbox"
alias dev="cd ~/Dropbox/dev"
alias dotfiles="cd ~/Dropbox/dev/dotfiles"


# UCD Repos
UCD="$HOME/Dropbox/dev/ucd"
alias ucd="cd $UCD"
alias proj="cd $UCD/blackteam"

alias c='clear'
alias ho='cd $HOME'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"


b() { # go back x directories
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

# Can Mark Directories to make it easy to jump to them
# SEE: 
export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}

  local wordlist=(`find $MARKPATH -type l | cut -d / -f 5`)

  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark


mcd() { # Make a Directory and CD in to it
   mkdir -p "$1" && cd "$1";
}

if is_osx; then
  FILE_MANAGER='open'
elif is_ubuntu; then
  FILE_MANAGER='nautilus'
elif is_win; then
  FILE_MANAGER='/bin/cygstart --explore'
fi

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0 ]; then
    $FILE_MANAGER . & 
  else
    $FILE_MANAGER "$@" & 
  fi;
}
