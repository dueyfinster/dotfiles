#!/usr/bin/env bash

if is_ubuntu; then
    alias copy='xclip -selection clipboard'
    alias paste='xclip -selection clipboard -o'
fi

if is_osx; then
    alias copy='pbcopy'
    alias paste='pbpaste'
fi


if is_win; then
    alias copy='/dev/clipboard'
    alias paste='cat /dev/clipboard'
fi
