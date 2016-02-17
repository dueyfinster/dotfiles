#!/bin/bash

# source tmuxinator completions
source $HOME/.tmuxinator/tmuxinator.bash

# bash_prompt
export TERM='screen-256color'
export PS1="\[\033[38;5;201m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;166m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;64m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput sgr0)\]\[\033[38;5;253m\]\A\[$(tput sgr0)\]\[\033[38;5;15m\] \\$ \[$(tput sgr0)\]"
