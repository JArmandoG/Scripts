#!/bin/bash
#
# Usage: harvest.sh example.com crtsh
# harvest.sh example.com otx
#
theHarvester -d $1 -b $2 
echo
echo '----------------------------------------------'
for IP in $(theHarvester -d $1 -b $2 | httprobe | sed 's/.*:\/\///'); 
do echo -e $IP '\t' $(nslookup $IP | grep 'name =' | awk '{print $NF}') ' \t ' $(whois $IP | grep -i orgname); 
done
