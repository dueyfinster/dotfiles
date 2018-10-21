# Turn off fish greeting
set -e  fish_greeting

# Solarized colours
. $HOME/.config/fish/solarized.fish

# load solarized colors
set -g theme_color_scheme solarized-dark
set -g __fish_git_prompt_show_informative_status 1

# Set path
set PATH ~/.dotfiles/bin ~/.fzf/bin $PATH

# Abbreviations
abbr -a e 'exit'

# Directory Shortcuts
abbr -a dx 'cd ~/Dropbox'
abbr -a de 'cd ~/Desktop'
abbr -a do 'cd ~/Documents'
abbr -a dw 'cd ~/Downloads'
abbr -a dr 'cd ~/repos'
abbr -a dt 'cd ~/.dotfiles'

# Git Abbreviations
abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gc 'git commit -m'
abbr -a gd 'git diff'
abbr -a gl 'git log'
abbr -a gs 'git status'
abbr -a gp 'git push'
abbr -a gpl 'git pull'
