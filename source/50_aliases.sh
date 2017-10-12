#!/usr/bin/env bash
# Application shortcuts
budget_file="$HOME/.hledger.journal"
alias ledger="ledger -f $budget_file"
alias budget="ledger -p \"this month\" --budget --monthly balance ^expenses"
alias bal="ledger bal ^Assets:Checking"
alias savings="ledger bal ^Assets:Savings"
alias monexp="ledger -MAn reg"
alias vb="vim $budget_file"
alias vi='vim'
alias tmux='tmux -2'
alias hist='history'
alias wotgobblemem='ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'
alias c='clear'

alias red-grep="GREP_COLOR='1;31' grep --color=always"
alias white-grep="GREP_COLOR='1;37' grep --color=always"

alias lf='ls -Gl | grep ^d' #Only list directories
alias lsd='ls -Gal | grep ^d' #Only list directories, including hidden ones
alias sweep='find ~ -type f \( -name '*.swp' -o -name 'wget.log' -o -name 'foobar*' -o -name '*~' -o -name '.netrwhist'  \) -delete' # clean temp files in home directory
alias hi='history | red-grep '
alias ga='alias | red-grep '

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


alias c='clear'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

b() { # go back x directories
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

mcd() { # Make a Directory and CD in to it
   mkdir -p "$1" && cd "$1";
}

if is_osx; then
  FILE_MANAGER='open'
elif is_ubuntu; then
  FILE_MANAGER='nautilus'
elif is_win; then
  FILE_MANAGER='/bin/cygstart --explore'
fi

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0 ]; then
    $FILE_MANAGER . & 
  else
    $FILE_MANAGER "$@" & 
  fi;
}


### System Specific Aliases {{{
if is_ubuntu; then
  alias copy='xclip -selection clipboard'
  alias paste='xclip -selection clipboard -o'
  alias ls='ls -F --color=auto'
  alias l.='ls -d .* --color=auto' # show hidden files only
  alias l='ls -lAh --color'
  alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
fi

if is_osx; then
  alias copy='pbcopy'
  alias paste='pbpaste'
  alias ls="ls -G"
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
alias tmu="tmuxifier"
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


# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
	if [ $# -eq 0 ]; then
		$EDITOR .;
	else
		$EDITOR "$@";
	fi;
}

export VISUAL="$EDITOR"
#alias vv="cd $DOTFILES/link && v $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias vv="cd $DOTFILES/link && v $DOTFILES/link/vimrc +'cd $DOTFILES'"
alias vd="cd $DOTFILES && v $DOTFILES"

# A collection of server and network commands {{{
alias httpserv="python -m SimpleHTTPServer" # Serve current directory as a webpage
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
