[![Build Status](https://travis-ci.org/dueyfinster/dotfiles.svg?branch=master)](https://travis-ci.org/dueyfinster/dotfiles)
[![Circle
CI](https://circleci.com/gh/dueyfinster/dotfiles/tree/master.svg?style=svg)](https://circleci.com/gh/dueyfinster/dotfiles/tree/master)
[![Build
status](https://ci.appveyor.com/api/projects/status/v0lhd0mf2997i73a?svg=true)](https://ci.appveyor.com/project/dueyfinster/dotfiles-0iv0q)
# dotfiles
## Install

```sh
bash -c "$(curl -fsSL https://bit.ly/dfdotfiles)" && source ~/.bashrc
```

### Subdirectories

* The `/backups` directory gets created when necessary. Any files in `~/` that would have been overwritten by files in `/copy` or `/link` get backed up there.
* The `/bin` directory contains executable shell scripts (including the [dotfiles][dotfiles] script) and symlinks to executable shell scripts. This directory is added to the path.
* The `/caches` directory contains cached files, used by some scripts or functions.
* The `/conf` directory just exists. If a config file doesn't **need** to go in `~/`, reference it from the `/conf` directory.
* The `/copy` directory contains config to be copied to local machine. Usually for stand-alone config, or config that can link itself to `/conf`
* The `/source` directory contains files that are sourced whenever a new shell is opened (in alphanumeric order, hence the funky names).
* The `/vendor` directory contains third-party libraries.

[dotfiles]: bin/dotfiles
