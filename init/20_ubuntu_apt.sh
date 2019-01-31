# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

export DEBIAN_FRONTEND=noninteractive

# Update APT.
e_header "Updating APT"
sudo apt -qq update

# Install APT packages.
packages=(
  build-essential
  bash-completion
  direnv
  exuberant-ctags
  fonts-mplus
  git
  software-properties-common
  tmux
  vim
)

packages=($(setdiff "${packages[*]}" "$(dpkg --get-selections | grep -v deinstall | awk '{print $1}')"))

if (( ${#packages[@]} > 0 )); then
  e_header "Installing APT packages: ${packages[*]}"
  sudo apt -y install  ${packages[*]}
fi
