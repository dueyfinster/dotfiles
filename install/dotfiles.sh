#!/usr/bin/env bash
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

function link_file_list(){
	if is_osx; then
		find "$link_dir" -mindepth 1 -maxdepth 1 -print0
	else
		find "$link_dir" -mindepth 1 -maxdepth 1 -printf "%P\n"
	fi	
}

function link_files(){
	local link_dir="$DOTFILES/link"
	link_file_list | while read -r file; do echo "Will link $link_dir/$file to $HOME/$file"; ln -sfn "$link_dir/$file" "$HOME/$file"; done
}

function unlink_files(){
	local link_dir="$DOTFILES/link"
	link_file_list | while read -r file; do echo "Will unlink $file to home"; unlink "$HOME/$file"; done
}

link_files
#unlink_files
