#!/usr/bin/env bash
# A collection of server and network commands

alias httpserv="python -m SimpleHTTPServer" # Serve current directory as a webpage
alias exip='curl ifconfig.me'
alias downweb='wget --random-wait -r -p -e robots=off -U mozilla $1' # download an entire website (takes url as argument) 

function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}
