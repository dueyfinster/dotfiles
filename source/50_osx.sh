# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH="/usr/local/bin:$(path_remove /usr/local/bin)"
export PATH
alias ls="ls -G"
export BROWSER="open"

export WORKON_HOME="~/.virtualenvs"
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"
alias python="python3"

# Trim new lines and copy to clipboard
#alias c="tr -d '\n' | pbcopy"
