#!/bin/bash

MOVE_DIR="$HOME/Documents/Downloads/ForiTunes"

transmission-remote -t $TORRENTID --move $MOVE_DIR
transmission-remote -t $TORRENTID --remove