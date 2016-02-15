#!/usr/bin/env bash
set -e # exit this script if child command exits in error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES="$(dirname "$DIR")"

# OS detection
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}
function is_win() { 
  [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || return 1
}

function get_os() {
  for os in osx ubuntu win; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}

function file_list(){
	if is_osx; then
		find "$1" -type f -exec basename {} \;
	else
		find "$1" -mindepth 1 -maxdepth 1 -printf "%P\n"
	fi	
}

function link_files(){
	local dir="$DOTFILES/$1"
	file_list "$dir" | while read -r file; do echo "Will link $dir/$file to $HOME/$file"; "$2 $3" "$dir/$file" "$HOME/$file"; done
}

function unlink_files(){
	local dir="$DOTFILES/$1"
	file_list "$1" | while read -r file; do echo "Will unlink $file to home"; "$2" "$HOME/$file"; done
}

cmd="ln -sfn"
link_files "link" $cmd
#unlink_files "link" "unlink"
