#!/usr/bin/env sh
# Copyright (c) 2015 Nathan Schulte

# set LOGIN and API_KEY below --
# see bottom for example use, in this case, checking and updating the default DNS A RR for a domain

# 0: request URI, e.g. '/dns/example.com/listRRs'
# 1..n: parameters

if [ "$#" -le 3 ]; then
  echo "Need a login name, API Key, domain and optionally a hostname"
fi
LOGIN=$1
API_KEY=$2
DOMAIN=$3
HOSTNAME=$4

make_request () {
    TIMESTAMP=$(date +%s)
    SALT=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 16)
    REQUEST_URI="$1"

    if [ "$#" -gt "1" ]; then
        PARAMETERS="$2"
    fi

    COUNT=3
    while test $COUNT -le $#
    do
        eval "PARAMETER=\$$COUNT"
        PARAMETERS="$PARAMETERS&$PARAMETER"
        COUNT=$((COUNT + 1))
    done

    BODY=$PARAMETERS
    BODY_HASH=$(printf "%s" "$BODY" | sha1sum | awk '{print $1}')
    HASH_STRING=$(printf "%s" "$LOGIN;$TIMESTAMP;$SALT;$API_KEY;$REQUEST_URI;$BODY_HASH")
    HASH=$(printf "%s" "$HASH_STRING" | sha1sum | awk '{print $1}')

    #echo "Hash String: $HASH_STRING"
    #echo "Hash: $HASH"
    #echo "Parameters: $PARAMETERS"
    #echo "Body: $BODY"
    #echo "Body Hash: $BODY_HASH"
    #echo "Login: $LOGIN"
    #echo "Timestamp: $TIMESTAMP"
    #echo "Salt: $SALT"
    #echo "API Key: $API_KEY"
    #echo "Request URI: $REQUEST_URI"

    #echo "requesting $REQUEST_URI with $BODY"
    printf "%s" "$(curl -s -o - -k -X POST -H "X-NFSN-Authentication: $LOGIN;$TIMESTAMP;$SALT;$HASH" -d "$BODY" "https://api.nearlyfreespeech.net$REQUEST_URI")"
}


A_RECORD=$(make_request "/dns/$DOMAIN/listRRs" "name=$HOSTNAME" 'type=A' | sed 's/.*"data":"\([0-9\.]*\)".*/\1/')
IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

echo "existing record: $A_RECORD"
echo "current address: $IP"

if [ "$IP" != "$A_RECORD" ]; then
    make_request "/dns/$DOMAIN/removeRR" "name=$HOSTNAME" 'type=A' "data=$A_RECORD"
    make_request "/dns/$DOMAIN/addRR" "name=$HOSTNAME" 'type=A' "data=$IP"
fi
