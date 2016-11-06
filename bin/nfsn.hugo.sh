#!/bin/bash
# A Scrit to do a hugo build if any future posts exist
set -x

cd $HOME/repos/ngrogan.com

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse origin)

if [ $LOCAL = $REMOTE ]; then
    :
else
	git pull
fi

~/bin/hugo -d $DOCUMENT_ROOT
