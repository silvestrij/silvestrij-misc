#!/bin/bash

#7 Jan 2013 - John B. Silvestri
#cf-mass-add.sh - uses cf-add-dns-a.sh to add many A records to DNS
#Replace given names with host entries, RFC1918 IPs with real ones
#
# Usage (once all desired records have been entered below)
# ./cf-mass-add.sh

./cf-add-dns-a.sh alice 192.168.1.1
./cf-add-dns-a.sh bob 10.1.2.3
./cf-add-dns-a.sh charlie 172.16.10.10
