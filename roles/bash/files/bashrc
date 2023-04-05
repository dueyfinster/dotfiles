source "$HOME/.config/bash/bash_prompt.sh"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';
# Append to History
shopt -s histappend
# Run History append after each prompt - so history is shared between currently open shells
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

export TERM="screen-256color"


# Add binaries into the path
export PATH="$HOME/bin:$DOTFILES/bin:$HOME/.tmuxifier/bin:$PATH"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,pack,minpac,vendor,plugins}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'
[ -f ~/.drone ] && source ~/.drone

# Add Dircolors
if [ -x "$(command -v dircolors)" ]; then
  eval $(dircolors "$HOME/.config/dircolors/dircolors.256dark")
fi

if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook bash)"
fi

# Source all files in "completion"
function completion() {
  local file
  for file in $HOME/.config/bash/completions/*; do
    source "$file"
  done
}

completion

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

source $HOME/.variables
source $HOME/.functions
source $HOME/.aliases
