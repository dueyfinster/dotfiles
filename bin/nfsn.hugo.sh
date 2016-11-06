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
NEEDS_UPDATE="false"
grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" -R content | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" | sed -e 's/\-//g' | while read line; do
  cond=$(date +"%Y%m%d")    # = 20130715

  if [ $line -ge $cond ]; #put the loop where you need it
  then
    NEEDS_UPDATE="true"
  fi
done

if [[ "$NEEDS_UPDATE" = true ]]; then
  ~/bin/hugo -d $DOCUMENT_ROOT
fi
