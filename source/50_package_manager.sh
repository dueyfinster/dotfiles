#!/usr/bin/env bash
# Alias common package management commands

command_exists () {
  type "$1" &> /dev/null ;
}

if command_exists apt-get; then
  alias pkgc="sudo apt-get autoremove"
  alias pkgi="sudo apt-get install"
  alias pkgr="sudo apt-get remove"
  alias pkgs="apt-cache search"
  alias pkgup="sudo apt-get update"
  alias pkgug="sudo apt-get upgrade"
elif command_exists brew; then
  alias pkgc="brew cleanup"
  alias pkgi="brew install"
  alias pkgr="brew remove"
  alias pkgs="brew search"
  alias pkgup="brew update"
  alias pkgug="brew upgrade"
fi