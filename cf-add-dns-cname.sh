#!/bin/bash

#7 Jan 2013 - John B. Silvestri
#Replace UPPER_CASE bits with appropriate values
#(except for CNAME - that's the record type)
# See CF's fantastic API docs here:
# https://www.cloudflare.com/docs/client-api.html
#
# Usage:
# ./cf-add-dns-cname.sh alice alice.saas-example.com

curl https://www.cloudflare.com/api_json.html -d 'a=rec_new' -d 'tkn=CLOUDFLARE_API_KEY' -d 'email=ADMIN_EMAIL' -d 'z=DOMAIN' -d 'type=CNAME' -d "name=$1" -d "content=$2" -d 'ttl=1' >> cf-add-dns.output.txt

