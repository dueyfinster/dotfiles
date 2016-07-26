#!/bin/bash
curl -s 'http://www.reddit.com/r/wallpapers' \
  | tr '"' '\n' | grep imgur | tee "$$.tmp" \
  | egrep '^http://i\.imgur\.com/' \
  | xargs wget -q -nc
egrep '^http://imgur.com/a/' "$$.tmp" \
  | xargs -l1 imgur_album_download.sh
rm "$$.tmp"