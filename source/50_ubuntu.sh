# Ubuntu stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# Solarized colors for GNU Utilities
#eval `dircolors $DOTFILES/vendor/dircolors-solarized/dircolors.256dark`

alias ls='ls -F --color=auto'
alias l.='ls -d .* --color=auto' # show hidden files only
alias l='ls -lAh --color'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''

export BROWSER="x-www-browser"
export WORKON_HOME="~/.virtualenvs"
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3.4"
alias python="python3"
export PATH="$HOME/.linuxbrew/bin:$PATH"

source /usr/local/bin/virtualenvwrapper.sh 2> /dev/null
