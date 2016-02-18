#!/usr/bin/env bash
# A collection of Version Control System (VCS) commands
# See https://gist.github.com/mwhite/6887990


if [[ "$(type -P brew)" ]] && is_osx; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
  fi
fi

if [[ is_ubuntu ]]; then
  if [ -f /usr/share/bash-completion/completions/git ]; then
      . /usr/share/bash-completion/completions/git
  fi
fi

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"

    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done
