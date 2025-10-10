#!/usr/bin/env bash
if [[ "$(uname)" == "Darwin" ]]; then
  # kanata --cfg ~/.config/kanata/mac.kbd
else
  # kanata --cfg ~/.config/kanata/linux.kbd
fi
