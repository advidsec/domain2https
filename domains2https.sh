#!/bin/bash
if [ -z "$1" ]; then
  echo "Use: ./domains2https.sh [domainsfile]"
  exit 1
fi
while read d || [[ -n $d ]]; do
  ip=$(curl -I -s http://$d |grep 'HTTP\|Server')
  ip2=$(curl -I -s -k https://$d |grep 'HTTP\|Server')
  if [ -n "$ip" ] || [ -n "$ip2" ]; then
    echo "http://$d ; $ip" | tr -d "\r\n"
    echo ""
    echo "https://$d ; $ip2" | tr -d "\r\n"
    echo ""
  else
    echo "$d => Fail resolving"
  fi
done < $1
