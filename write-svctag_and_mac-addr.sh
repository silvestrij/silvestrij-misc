#!/bin/bash

#28 Jul 2010 - John B. Silvestri
#write-svctag_and_mac-addr.sh - used as a startup script in
#Puppy Linux to acquire key data on a new computer and write
#back to the same USB key containing said distro
#A shutdown will be executed upon successful data collection

#Input: 'mac-addrs.csv' - first column should contain
#Dell Service Tag; no additional data required

#Output: For relevant service tags, related MAC address will be appended
#in two formats (upper case, with dashes; all lowercase sans punctuation)

#Get Service Tag
export a=`dmidecode -s system-serial-number`
#export a=123ABC1

#Get MAC addr and change colon to hyphen (specific use case)
export b=`ifconfig eth0|grep HWaddr|sed -e "s/.*HWaddr //" -e "s/:/-/g" -e"s/ //g"`
#export b=00-11-22-33-44-55

#Drop case and remove hyphens
export c=`echo $b |tr "[:upper:]" "[:lower:]"|sed -e "s/-//g"`

#Put all 3 pieces of data in a CSV file, with CR added for Windows
export result="$a,$b,$c"
#echo "$result" #debug

sed -ie "s/^$a.*/$result/" /mnt/home/mac-addrs.csv
#sed -ie "s/^$a.*/$result\\r/" mac-addrs.csv

#Shutdown computer
wmpoweroff
