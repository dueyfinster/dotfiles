#!/usr/bin/env bash
# Application shortcuts

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


#### Shell & System ####
alias scriptcom='echo "!!" > $1' # Create a script of the last executed command (takes a filename.sh as argument)
alias ds='du -ks *|sort -n' # Find the biggest in a folder
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30' # show most used commands
alias sulast='sudo $(history -p !-1)' # add sudo to last command
alias k9='kill -9'
alias tm='ps -ef | grep'
