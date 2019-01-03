#!/bin/bash
# A script to dynamically update DNS on Cloudflare

[[ $# -lt 3 ]] && echo "Usage: $0 USERNAME PASSWORD ZONE DNSRECORD" && exit 1

USERNAME=${1}
PASSWORD=${2}
zone=${3}
dnsrecord=${4}

function get_ipv4(){
  curl -s -X GET https://checkip.amazonaws.com | echo
}

function get_ipv6(){
  # TODO
  curl -s -X GET https://checkip.amazonaws.com | echo
}

function get_zone_id(){
  curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$1&status=active" \
    -H "X-Auth-Email: $2" \
    -H "X-Auth-Key: $3" \
    -H "Content-Type: application/json" \
    | jq -r '{"result"}[] | .[0] | .id' \
    | echo
}

function get_record_id(){
  curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$1/dns_records?type=$2&name=$dnsrecord" \
    -H "X-Auth-Email: $4" \
    -H "X-Auth-Key: $5" \
    -H "Content-Type: application/json" \
    | jq -r '{"result"}[] | .[0] | .id' \
    | echo
}

function get_record_value(){
  curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$1/dns_records?type=$2&name=$3" \
  -H "X-Auth-Email: $4" \
  -H "X-Auth-Key: $5" \
  -H "Content-Type: application/json" \
  | jq -r '{"result"}[] | .[0] | .content' \
  | echo
}

function update_record_value(){
  curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$1/dns_records/$2" \
  -H "X-Auth-Email: $3" \
  -H "X-Auth-Key: $4" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"$5\",\"name\":\"$dnsrecord\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":false}" | jq
}

function main(){
  # Get the current external IP address
  ip=$()
  echo "Current IP is $ip"
  
  zoneid=$(get_zone_id $zone $USERNAME $PASSWORD)
  echo "Zoneid for $zone is $zoneid"
  
  dnsrecordid=$(get_record_id $zoneid A $dnsrecord $USERNAME $PASSWORD)
  echo "DNSrecordid for $dnsrecord is $dnsrecordid"

  current_ip4=$(get_record_value $zoneid A $dnsrecord $USERNAME $PASSWORD)
  echo "Current ip4 on cloudflare is: $current_ip4"
  
  # update the record
  if [ "$ip" != "$current_ip4" ]; then
    update_record_value $zoneid $dnsrecordid $USERNAME $PASSWORD A $ip
  else
    echo "The Two IP Address are the same, no changes needed."
  fi
}

main 
