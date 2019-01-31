# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

RG_VERSION="0.10.0"

ignore_output() {
  "$@" > /dev/null 2>&1
}

download_binary() {
  local version="$1"
  local bin_name="$2"

  curl \
    --location \
    --silent \
    --show-error \
    "https://github.com/BurntSushi/ripgrep/releases/download/$version/$bin_name" -o "$3/$bin_name"
}

downloaded_binary() {
  local version="$1"

  ignore_output command -v rg && rg --version | grep --quiet "$version"
}

install_linux() {
  local version="$1"
  local bin_name="ripgrep_${version}_amd64.deb"

  if ! downloaded_binary $version; then
    echo "Installing rg v$version"

    tmp_dir=$(mktemp --directory)

    download_binary "$version" "$bin_name" "$tmp_dir"

    sudo dpkg -i "$tmp_dir"/*.deb

    rm -rf $tmp_dir
  fi
}

install_windows() {
  local version="$1"
  local bin_name="ripgrep-${version}-x86_64-pc-windows-msvc.zip"

  if ! downloaded_binary $version; then
    echo "Installing rg v$version"

    tmp_dir=$(mktemp --directory)

    download_binary "$version" "$bin_name" "$tmp_dir"

    unzip "$tmp_dir"/*.zip

    #TODO move binary to correct location

    rm -rf $tmp_dir
  fi
}

main() {
  local version="$RG_VERSION"
  local dist="$(uname -s)"

  case "$dist" in
    Linux)
      install_linux "$version"
      ;;
    MINGW64_NT-10.0)
      install_windows "$version"
      ;;
    *)
      echo "Don't know how to install rg on $dist"
      exit 1
  esac
}

main "$@"
