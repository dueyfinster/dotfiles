# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

RG_VERSION="${1:-0.7.1}"

ignore_output() {
  "$@" > /dev/null 2>&1
}

binary_name() {
  local version="$1"
  echo "ripgrep-${version}-x86_64-unknown-linux-musl"
}

download_binary() {
  local version="$1"

  curl \
    --location \
    --silent \
    --show-error \
    "https://github.com/BurntSushi/ripgrep/releases/download/$version/$(binary_name $version).tar.gz"
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

    ignore_output pushd $tmp_dir
    download_binary "$version" | tar -zxf -
    ignore_output popd

    # binary
    mv "$tmp_dir/$(binary_name $version)/rg" "$HOME/bin"

    # man pages
    # mv "$tmp_dir/$(binary_name $version)/rg.1" "${XDG_MAN_HOME}/man1/"

    # bash completion
    # mkdir -p "${XDG_DATA_HOME}/rg"
    # mv "$tmp_dir/$(binary_name $version)/complete/rg.bash-completion" "${XDG_DATA_HOME}/rg"

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
