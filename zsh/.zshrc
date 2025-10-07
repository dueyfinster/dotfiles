# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# CTRL+F bound to find tmux session
bindkey -s ^f "tm\n"


# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 5000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

source $HOME/.variables
source $HOME/.functions
source $HOME/.aliases

# Source local config - if it exists
if [[ -f "${HOME}/.zshrc.local" ]]; then
  source "${HOME}/.zshrc.local"
fi

# Load completions
autoload -Uz compinit && compinit

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
