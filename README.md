# dotfiles
## Install

```sh
bash -c "$(curl -fsSL https://bit.ly/dfdotfiles)" && source ~/.bashrc
```

## Install without git

```sh
cd; curl -#L https://github.com/dueyfinster/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,LICENSE}
```

## Subdirectories

Each directory can used with [GNU Stow](https://www.gnu.org/software/stow/) to use those config files.
