#!/bin/bash
TRANS_BIN="/usr/local/bin/transmission-remote"

MOVE_DIR="$HOME/Documents/Downloads/Complete"

"$TRANS_BIN" -t "$TR_TORRENT_ID" --move "$MOVE_DIR"
sleep 2
"$TRANS_BIN" -t "$TR_TORRENT_ID" --remove