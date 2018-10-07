#!/usr/bin/env bash
# Application shortcuts
export LEDGERFILE="$HOME/.hledger.journal"
alias budget="ledger -p \"this month\" --budget --monthly balance ^expenses"
alias bal="ledger bal ^Assets:Checking"
alias savings="ledger bal ^Assets:Savings"
alias monexp="ledger -MAn reg"
alias vb="vim $LEDGERFILE"
alias hist='history'
alias wotgobblemem='ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'
alias c='clear'

ytdl() {
  TOKEN=$(cat "$HOME"/.hook)
  curl -X POST --data "token=$TOKEN" --data "url=$1" https://hook.ballyda.com/hooks/yt-dl
}

# Normalize `open` across Linux, macOS, and Windows.
# This is needed to make the `o` function (see below) cross-platform.
if [ ! $(uname -s) = 'Darwin' ]; then
	if grep -q Microsoft /proc/version; then
		# Ubuntu on Windows using the Linux subsystem
		alias open='explorer.exe';
	else
		alias open='xdg-open';
	fi
fi

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}


# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

### Git Commands {{{
# if [ ! -x "$(command -v brew)" ] | [ -f $(brew --prefix)/etc/bash_completion ]; then
#       . $(brew --prefix)/etc/bash_completion
# elif [ -f /usr/share/bash-completion/completions/git ]; then
#       . /usr/share/bash-completion/completions/git
# fi

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

if [ -n "$(type -t __git_aliases)" ]; then
  for al in `__git_aliases`; do
      alias g$al="git $al"

      complete_func=_git_$(__git_aliased_command $al)
      function_exists $complete_fnc && __git_complete g$al $complete_func
  done
fi
# }}}

# Shell & System {{{
alias scriptcom='echo "!!" > $1' # Create a script of the last executed command (takes a filename.sh as argument)
alias ds='du -ks *|sort -n' # Find the biggest in a folder
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30' # show most used commands
alias sulast='sudo $(history -p !-1)' # add sudo to last command
alias k9='kill -9'
alias tms='ps -ef | grep'
# }}}

# SSH Tunnel {{{
tunnel(){
  ssh home -L "$1":localhost:"$1"
}

rtunnel(){
    ssh -R 80:localhost:"$1" serveo.net
}
# }}}

# Docker commands {{{
dshell(){
 docker exec -i -t $1 /bin/bash
}

function d(){
  docker "$@"
}

function dc(){
  docker-compose "$@"
}
# }}}


export EDITOR='vim'

# A collection of server and network commands {{{
alias httpserv="python -m SimpleHTTPServer" # Serve current directory as a webpage
alias downweb='wget --random-wait -r -p -e robots=off -U mozilla $1' # download an entire website (takes url as argument)


ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}
# }}}
