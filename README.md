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

## Shared agent configuration

Agent instructions and skills have one canonical source under `agents/`. After
stowing `bin`, publish them to Claude, Codex, and Kiro with:

```sh
agent-share sync
```

Use `agent-share check` to detect missing, outdated, or conflicting outputs.
