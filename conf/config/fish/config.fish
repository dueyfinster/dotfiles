# Turn off fish greeting
set -e  fish_greeting

# Solarized colours
. $HOME/.config/fish/solarized.fish

# load solarized colors
set -g theme_color_scheme solarized-dark
set -g __fish_git_prompt_show_informative_status 1

# Abbreviations
abbr -a e 'exit'
abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gc 'git commit -m'
abbr -a gd 'git diff'
abbr -a gl 'git log'
abbr -a gs 'git status'
abbr -a gp 'git push'
abbr -a gpl 'git pull'
