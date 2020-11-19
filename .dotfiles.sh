#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function link(){
  for file in $(git ls-files); do
    if [ ! -L ~/$file ]; then
      ln -s $DIR$file ~/$file
    fi
  done
}

function unlink(){
  for file in *; do
    unlink ~/$file
  done
}

function copy-ssh(){
  local id_path="~/Dropbox/Apps/dotfiles"
  for file in $(id_path/*); do
    echo "file"
  done
}

$1
