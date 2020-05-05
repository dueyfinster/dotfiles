# Turn off fish greeting
set -e  fish_greeting

# Solarized colours
. $HOME/.config/fish/solarized.fish

# load solarized colors
set -g theme_color_scheme solarized-dark
set -g __fish_git_prompt_show_informative_status 1

# Set path
set PATH ~/bin $PATH
set PATH ~/.dotfiles/bin $PATH
if test -d ~/.fzf/bin
  set PATH ~/.fzf/bin $PATH
end

# Set LEDGERFILE
set -xU LEDGERFILE ~/.hledger.journal
set -xU EDITOR vim

# Abbreviations
abbr -a x 'exit'

# Directory Shortcuts
abbr -a de 'cd ~/Desktop'
abbr -a do 'cd ~/Documents'
abbr -a dw 'cd ~/Downloads'
abbr -a dr 'cd ~/repos'
abbr -a dt 'cd ~/.dotfiles'

# Docker abbreviations
abbr -a dc 'docker-compose'

# Git Abbreviations
abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gc 'git commit -m'
abbr -a gco 'git checkout'
abbr -a gd 'git diff'
abbr -a gl 'git log'
abbr -a gs 'git status'
abbr -a gp 'git push'
abbr -a gpl 'git pull'

abbr -a tx 'tmuxinator'
# Aliases
alias e 'vim +Files'

# Ledger aliases
alias budget 'ledger -p \"this month\" --budget --monthly balance ^expenses'
alias bal 'ledger bal ^Assets:Checking'
alias savings 'ledger bal ^Assets:Savings'
alias monexp 'ledger -MAn reg'

if test "$TERM" = "dumb"
  function fish_prompt
    echo "\$ "
  end

  function fish_right_prompt; end
  function fish_greeting; end
  function fish_title; end
end
