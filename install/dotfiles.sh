#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES="$(dirname "$DIR")"


function link_file_list(){
	find "$link_dir" -mindepth 1 -maxdepth 1 -printf "%P\n"
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
