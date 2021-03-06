#!/bin/bash
# A script to dynamically update DNS on Cloudflare
set -euo pipefail
IFS=$'\n\t'
readonly SCRIPT_NAME=$(basename "$0")

readonly USERNAME=${1}
readonly PASSWORD=${2}
readonly zone=${3}
readonly dnsrecord=${4}

log() {
  echo "$@"
  logger -p user.notice -t "$SCRIPT_NAME" "$@"
}

err() {
  echo "$@" >&2
  logger -p user.error -t "$SCRIPT_NAME" "$@"
}

[[ $# -lt 3 ]] && err "Usage: $0 USERNAME PASSWORD ZONE DNSRECORD" && exit 1

function check_command(){
    if ! command -v "$1" &> /dev/null
    then
        err "$1 could not be found, you should install it!"
        exit 1
    fi
}

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

function get_cloudflare_ip(){
    zoneid=$(request "?name=$zone&status=active" ".id")
    dnsrecordid=$(request "$zoneid/dns_records?type=$iptype&name=$dnsrecord" ".id")
    request "$zoneid/dns_records?type=$1&name=$dnsrecord" ".content"
}

function update_ip_if_changed(){
    # update the record
    if [ "$ip" != "$cf_ip" ]; then
      log "Updating the $iptype address as it changed from: $ip to $current_ip"
      update_record_value "$zoneid" "$dnsrecordid" "$USERNAME" "$PASSWORD" "$iptype" "$ip"
    else
      log "The two $iptype addresses are the same, no changes needed."
    fi
}

function main(){
  # Check dependencies
  check_command curl
  check_command jq

  for iptype in A; do # Can add AAAA as a type to check for IPv6
    ip=$(get_ip "$iptype")
    cf_ip=$(get_cloudflare_ip "$iptype")
    update_ip_if_changed "$ip" "$cf_ip"
  done
}

main
