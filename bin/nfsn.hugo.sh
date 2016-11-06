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
grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" -R content | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" | while read line; do
  todate=$(date -d \"$line\" +"%Y%m%d")  # = 20130718
  cond=$(date +"%Y%m%d")    # = 20130715

  if [ $todate -ge $cond ]; #put the loop where you need it
  then
     ~/bin/hugo -d $DOCUMENT_ROOT
     exit 0
  fi
done
