#!/usr/bin/env bash
# Editing

export EDITOR='vim'


# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
	if [ $# -eq 0 ]; then
		$EDITOR .;
	else
		$EDITOR "$@";
	fi;
}

export VISUAL="$EDITOR"
#alias vv="cd $DOTFILES/link && v $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias vv="cd $DOTFILES/link && v $DOTFILES/link/vimrc +'cd $DOTFILES'"
alias vd="cd $DOTFILES && v $DOTFILES"
alias vblog="v +'cd $HOME/Dropbox/Blog'"
# Colour code output, needs pygments installed
alias ccat='pygmentize -g'
