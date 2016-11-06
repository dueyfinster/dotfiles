#!/bin/bash
# A Scrit to do a hugo build if any future posts exist
set -x
cd $HOME/repos/ngrogan.com
git pull
~/bin/hugo -d $DOCUMENT_ROOT
