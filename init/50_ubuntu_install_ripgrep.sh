# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

RG_VERSION="${1:-0.10.0}"

ignore_output() {
  "$@" > /dev/null 2>&1
}

binary_name() {
  local version="$1"
  echo "ripgrep-${version}_amd64.deb"
}

download_binary() {
  local version="$1"
  local bin_name=$(binary_name $version)

  curl \
    --location \
    --silent \
    --show-error \
    "https://github.com/BurntSushi/ripgrep/releases/download/$version/$bin_name" -o "$2/$bin_name"
}

downloaded_binary() {
  local version="$1"

  ignore_output command -v rg && rg --version | grep --quiet "$version"
}

install_linux() {
  local version="$1"

  if ! downloaded_binary $version; then
    echo "Installing rg v$version"

    tmp_dir=$(mktemp --directory)

    download_binary "$version" "$tmp_dir"

    sudo dpkg -i "$tmp_dir"/*.deb

    rm -rf $tmp_dir
  fi
}

main() {
  local version="${1:-$RG_VERSION}"
  local dist="$(uname -s)"

  case "$dist" in
    Linux)
      install_linux "$version"
      ;;
    *)
      echo "Don't know how to install rg on $dist"
      exit 1
  esac
}

main "$@"
