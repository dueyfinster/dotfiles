# Where the magic happens.
export DOTFILES=~/.dotfiles
export TERM="screen-256color"

# Set config variables first
GIT_PROMPT_ONLY_IN_REPO=1
#GIT_PROMPT_THEME="Custom"
GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${Blue}\h${ResetColor}: ${Yellow}${PathShort}${ResetColor}"
GIT_PROMPT_THEME=Solarized
#source $DOTFILES/vendor/bash-git-prompt/gitprompt.sh

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

src


# added by Anaconda3 4.0.0 installer
export PATH="/home/egronei/anaconda3/bin:$PATH"

PATH="/home/egronei/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/egronei/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/egronei/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/egronei/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/egronei/perl5"; export PERL_MM_OPT;
