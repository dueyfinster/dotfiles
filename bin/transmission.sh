#!/bin/bash

MOVE_DIR="$HOME/Documents/Downloads/Complete"

transmission-remote -t $TR_TORRENT_ID --move $MOVE_DIR
transmission-remote -t $TR_TORRENT_ID --remove