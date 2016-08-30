#!/usr/bin/env bash
# Application shortcuts
budget_file="$HOME/.hledger.journal"
alias ledger="ledger -f $budget_file"
alias budget="ledger -p \"this month\" --budget --monthly balance ^expenses"
alias bal="ledger bal ^Assets:Checking"
alias vb="vim $budget_file"
alias vi='vim'
alias tmux='tmux -2'
alias hist='history'
alias wotgobblemem='ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'
alias c='clear'

alias grey-grep="GREP_COLOR='1;30' grep --color=always"
alias red-grep="GREP_COLOR='1;31' grep --color=always"
alias green-grep="GREP_COLOR='1;32' grep --color=always"
alias yellow-grep="GREP_COLOR='1;33' grep --color=always"
alias blue-grep="GREP_COLOR='1;34' grep --color=always"
alias magenta-grep="GREP_COLOR='1;35' grep --color=always"
alias cyan-grep="GREP_COLOR='1;36' grep --color=always"
alias white-grep="GREP_COLOR='1;37' grep --color=always"

alias highlight-green="green-grep -C 10000"
alias highlight-red="red-grep -C 10000"
alias highlight-yellow="yellow-grep -C 10000"

alias lf='ls -Gl | grep ^d' #Only list directories
alias lsd='ls -Gal | grep ^d' #Only list directories, including hidden ones
alias sweep='find ~ -type f \( -name '*.swp' -o -name 'wget.log' -o -name 'foobar*' -o -name '*~' -o -name '.netrwhist'  \) -delete' # clean temp files in home directory
alias hi='history | red-grep '
alias ga='alias | red-grep'

extract () { # extracts common archives
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

ft() {
    find . -name "$2" -exec grep -il "$1" {} \;
}


### Clipboard {{{
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
# }}}

# Shell & System {{{
alias scriptcom='echo "!!" > $1' # Create a script of the last executed command (takes a filename.sh as argument)
alias ds='du -ks *|sort -n' # Find the biggest in a folder
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30' # show most used commands
alias sulast='sudo $(history -p !-1)' # add sudo to last command
alias k9='kill -9'
alias tms='ps -ef | grep'
# }}}

### Git Commands {{{
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
# }}}

# Docker commands {{{
alias d="docker"
alias di='docker images'
alias dps='docker ps'
alias dim='docker images'
alias dka='docker kill $(docker ps -q --no-trunc)'
alias dsta='docker stop $(docker ps -q --no-trunc)'
alias drmae='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'
alias drmiad='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias dr='docker run'
alias dritrm='docker run -it --rm'
#alias dr='docker run -it --rm'
alias dpsa='docker ps -a'
alias din='docker inspect'

alias dc="docker-compose"
alias dcu="docker-compose up -d"
alias dcl="docker-compose logs"
alias dck="docker-compose kill"
alias dcr="docker-compose rm"
alias dcrf="docker-compose rm -f"

alias dm="docker-machine"

function d(){
  docker "$@"
}
# }}}

# A collection of server and network commands {{{
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
# }}}
