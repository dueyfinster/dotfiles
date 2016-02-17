#!/usr/bin/env bash
# A collection of Version Control System (VCS) commands

if [ -f ${HOME}/.dotfiles/vendor/git-completion/git-completion.bash ]; then
  . ${HOME}/.dotfiles/vendor/git-completion/git-completion.bash
  
  # Add git completion to aliases
  __git_complete g __git_main
  __git_complete ga _git_add
  __git_complete gc _git_commit
  __git_complete gco _git_checkout
  __git_complete gf _git_fetch
  __git_complete gm __git_merge
  __git_complete gp _git_push
  __git_complete gst _git_stash
fi

# Make sure you actually have those aliases defined, of course.
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gcl="git clone"
alias gco="git checkout"
alias gdlc="git diff --cached HEAD^" # Diff from last commit
alias gf="git fetch" 
alias gfi="git ls-files | grep -i"
alias gfo="git fetch origin" 
alias gl="git log --pretty=format:'%C(yellow)%h%Cred%d %Creset%s%Cgreen [%cn]' --decorate" # Show last commits
alias gld="git log --pretty=format:'%C(yellow)%h %ad%Cred%d %Creset%s%Cgreen [%cn]' --decorate --date=relative " # show last commits by relative date 
alias gls="git log --pretty=format:'%C(yellow)%h%Cred%d %Creset%s%Cgreen [%cn]' --decorate --numstat" # show last commits with files modified
alias gm="git merge"
alias gp="git push"
alias gpm="git push origin master"
alias grh="git reset --hard origin/master"
alias grm="git push origin HEAD:refs/for/master"
alias gs="git status -s"
alias gst="git stash"

#### Git Commands ####
#alias ga="git add -u"
#alias gaa="git add -A"
#alias gb="git branch"
#alias gc="git commit -m "$1""
#alias gcob="git checkout -b "$1""
#alias gcom="git checkout master"
#alias gfl="git log -u "$1""

#alias gpdev="git push origin development"
#alias glg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

#da = difftool -d
#diffl = difftool -d master..HEAD^
#dlc = difftool --dir-diff --cached HEAD^ #Show diff last commit
#fl = log -u #Show diffs to a file
#ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat # Show Commits Annotated format with files changed
#ld = log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative  # Show Commits Annotated format with relative dates (can pass days like: -5 for 5 days etc)
#lds = log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short # Show Commits Annotated format with dates (can pass days like: -5 for 5 days etc)
