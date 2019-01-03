#!/bin/bash
# A script to dynamically update DNS on Cloudflare

[[ $# -lt 3 ]] && echo "Usage: $0 USERNAME PASSWORD ZONE DNSRECORD" && exit 1

COOKIEJAR=/tmp/cf_cookie.txt
USERNAME=${1}
PASSWORD=${2}
zone=${3}
dnsrecord=${4}


# Get the current external IP address
ip=$(curl -s -X GET https://checkip.amazonaws.com)

echo "Current IP is $ip"
# if here, the dns record needs updating

# get the zone id for the requested zone
zoneid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$zone&status=active" \
  -H "X-Auth-Email: $USERNAME" \
  -H "X-Auth-Key: $PASSWORD" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

echo "Zoneid for $zone is $zoneid"

# get the dns record id
dnsrecordid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records?type=A&name=$dnsrecord" \
  -H "X-Auth-Email: $USERNAME" \
  -H "X-Auth-Key: $PASSWORD" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

echo "DNSrecordid for $dnsrecord is $dnsrecordid"

# update the record
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records/$dnsrecordid" \
  -H "X-Auth-Email: $USERNAME" \
  -H "X-Auth-Key: $PASSWORD" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$dnsrecord\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":false}" | jq
