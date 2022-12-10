# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

local DIR_PATH="$HOME/.dotfiles/.config/dircolors/dircolors.256dark"
export PATH="$HOME/bin:$HOME/.dotfiles/bin:$PATH"
if type dircolors > /dev/null 2>&1; then
    eval $(dircolors "$DIR_PATH")
elif type gdircolors > /dev/null 2>&1; then
    eval $(gdircolors "$DIR_PATH")
    alias ls="ls -G"
fi

#autocompletion
setopt AUTOLIST
setopt extended_glob
setopt prompt_subst

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

autoload -Uz compinit
compinit

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

function user_color {
  if [[ "$SSH_TTY" ]]; then
    usercolor=${solarized[CYAN]};
  elif [[ "$USER" == "root" ]]; then
    usercolor=${solarized[RED]};
	else
    usercolor=${solarized[ORANGE]};
  fi
}

setprompt () {
    local MAX_DIR_LEN=45
    user_color
    PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
    PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt)${RESET_COLOR}'
}

setprompt

unset git_prompt setprompt

# MacOS
if [[ -a /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Linux
if [[ -a /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

source $HOME/.variables
source $HOME/.functions
source $HOME/.aliases
