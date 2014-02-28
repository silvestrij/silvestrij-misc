#!/bin/bash

#7 Jan 2013 - John B. Silvestri
#cf-add-dns-a.sh - add a single A record to DNS
#Replace UPPER_CASE bits with appropriate values
#(except for A - that's the record type)
# See CF's fantastic API docs here:
# https://www.cloudflare.com/docs/client-api.html
#
# Usage:
# ./cf-add-dns-a.sh alice 192.168.1.1

curl https://www.cloudflare.com/api_json.html -d 'a=rec_new' -d 'tkn=CLOUDFLARE_API_KEY' -d 'email=ADMIN_EMAIL' -d 'z=DOMAIN' -d 'type=A' -d "name=$1" -d "content=$2" -d 'ttl=1' >> cf-add-dns.output.txt

