#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ ! "$(type -P rsync)" ]]; then
  echo "RSync must be installed first."
  exit 1
fi

rsync -avz "$HOME"/Dropbox/Apps/dotfiles/ "$HOME"/.dotfiles/
