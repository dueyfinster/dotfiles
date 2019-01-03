#!/bin/bash
# A script to dynamically update DNS on Cloudflare
[[ $# -lt 3 ]] && echo "Usage: $0 USERNAME PASSWORD ZONE DNSRECORD" && exit 1

USERNAME=${1}
PASSWORD=${2}
zone=${3}
dnsrecord=${4}

function get_ip(){
  if [ "$1" == "A" ]; then
    curl -4 -s -X GET https://checkip.amazonaws.com
  else
    curl -6 -s -X GET https://ifconfig.co
  fi
}

function request(){
  curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$1" \
    -H "X-Auth-Email: $USERNAME" \
    -H "X-Auth-Key: $PASSWORD" \
    -H "Content-Type: application/json" \
    | jq -r "{\"result\"}[] | .[0] | $2"
}

function update_record_value(){
  curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$1/dns_records/$2" \
  -H "X-Auth-Email: $3" \
  -H "X-Auth-Key: $4" \
  -H "Content-Type: application/json" \
  --data "{\"type\":"\"$5\"",\"name\":\"$dnsrecord\",\"content\":"\"$6\"",\"ttl\":1,\"proxied\":false}" | jq
}

function main(){
  for iptype in AAAA A; do
    # Get the current external IP address
    ip=$(get_ip $iptype)
    echo "Current IP is $ip"

    zoneid=$(request "?name=$zone&status=active" ".id")
    echo "Zoneid for $zone is $zoneid"


    dnsrecordid=$(request "$zoneid/dns_records?type=$iptype&name=$dnsrecord" ".id")
    echo "DNSrecordid for $dnsrecord is $dnsrecordid"

    current_ip=$(request "$zoneid/dns_records?type=$iptype&name=$dnsrecord" ".content")
    echo "Current $iptype on cloudflare is: $current_ip"

    # update the record
    if [ "$ip" != "$current_ip" ]; then
      update_record_value $zoneid $dnsrecordid $USERNAME $PASSWORD $iptype $ip
    else
      echo "The Two IP Address are the same, no changes needed."
    fi
  done
}

main
