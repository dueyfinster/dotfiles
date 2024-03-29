# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# CTRL+F bound to find tmux session
bindkey -s ^f "tm\n"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf git zsh-autosuggestions zsh-completions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

local DIR_PATH="$HOME/.config/dircolors/dircolors.256dark"
export PATH="$HOME/.local/bin:$PATH"
if type dircolors > /dev/null 2>&1; then
    eval $(dircolors "$DIR_PATH")
elif type gdircolors > /dev/null 2>&1; then
    eval $(gdircolors "$DIR_PATH")
    alias ls="ls -G"
fi

# ~/.shell/prompt.zsh

# solarized colors {{{
# http://ethanschoonover.com/solarized

autoload -U colors && colors

typeset -lA solarized
solarized[BASE03]=$'\e[38;5;234m'
solarized[BASE02]=$'\e[38;5;235m'
solarized[BASE01]=$'\e[38;5;240m'
solarized[BASE00]=$'\e[38;5;241m'
solarized[BASE0]=$'\e[38;5;244m'
solarized[BASE1]=$'\e[38;5;245m'
solarized[BASE2]=$'\e[38;5;254m'
solarized[BASE3]=$'\e[38;5;230m'
solarized[YELLOW]=$'\e[38;5;136m'
solarized[ORANGE]=$'\e[38;5;166m'
solarized[RED]=$'\e[38;5;160m'
solarized[MAGENTA]=$'\e[38;5;125m'
solarized[VIOLET]=$'\e[38;5;61m'
solarized[BLUE]=$'\e[38;5;33m'
solarized[CYAN]=$'\e[38;5;37m'
solarized[GREEN]=$'\e[38;5;64m'
RESET_COLOR="%{$terminfo[sgr0]%}"

# }}}

setopt prompt_subst

function git_prompt {
    local GIT_SYMBOL="%%{$solarized[GREEN]%%}± "
    local DIRTY_COLOR="%%{$solarized[YELLOW]%%}"
    local CLEAN_COLOR="%%{$solarized[GREEN]%%}"
    local UNMERGED_COLOR="%%{$solarized[RED]%%}"

    case "$PWD" in
        /mnt/*|/Volumes/*) return ;;
    esac

    git rev-parse --git-dir > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        return
    fi

    local ref
    ref=${$(command git symbolic-ref HEAD 2> /dev/null)#refs/heads/} || \
        ref=${$(command git rev-parse HEAD 2>/dev/null)[1][1,7]} || \
        return

    local branchcolor
    if [[ `git ls-files -u >& /dev/null` == '' ]]; then  # in a merge?
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]; then
        branchcolor=$DIRTY_COLOR
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]; then
          branchcolor=$DIRTY_COLOR
        else
          branchcolor=$CLEAN
        fi
      fi
    else
      branchcolor=$UNMERGED_COLOR
    fi
    print -Pn '%%{${solarized[BASE0]}%%}('
    print -Pn '${GIT_SYMBOL}%%{$branchcolor%%}%50>..>${ref}%<<'
    print -Pn '%%{${solarized[BASE0]}%%}) '
}

setprompt () {
  if [[ $SSH_CONNECTION ]]; then
    #at remote session
    PROMPT="%{$fg_bold[magenta]%}%m %(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)"
  else
    PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
  fi
  PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt)${RESET_COLOR}'
}

setprompt

unset git_prompt setprompt

#autocompletion
setopt AUTOLIST
setopt extended_glob
setopt prompt_subst


autoload -Uz compinit
compinit

source $HOME/.variables
source $HOME/.functions
source $HOME/.aliases

# Source local config - if it exists
if [[ -f "${HOME}/.zshrc.local" ]]; then
  source "${HOME}/.zshrc.local"
fi
