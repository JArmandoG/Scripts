#!/bin/bash

# USAGE:
# dns_recursive_search.sh domain.com

# Nslookup recursively (Find IPs and do a recursive Nslookup with the resulting IPs)
# Example results: example.com -> 129.2.32.1 -> ec2-3-144-99-31.us-east-2.compute.amazonaws.com

DOMAIN=$1
OUTFILE=$1.subdomains
HTTPROBED=$1.subdomains.httprobed
NSLOOKUP=$1.subdomains.nslookupIPs
RECURSIVE_DNS=$1.subdomains.nslookup.recursive
DOMAIN_LIST=$(cat $1)

echo $DOMAIN_LIST

for domain in $DOMAIN_LIST; do echo $domain | sed 's/\"//g' | tr -d "," >> $OUTFILE; done

echo "--------------------------------------------------------------------------"
echo "Hosts:"
cat $OUTFILE | httprobe | tee $HTTPROBED

echo "--------------------------------------------------------------------------"
echo "NSLOOKUPS:"

cat $HTTPROBED | sed 's/.*:\/\///' | nslookup | grep -v 'Address:	'| grep Address | sed 's/Address: //' | tee $NSLOOKUP

echo "--------------------------------------------------------------------------"
echo "RECURSIVE DNS:"

for line in $(cat $NSLOOKUP | sed 's/.*:\/\///' ); do nslookup $line | grep 'name = ' | awk '{print $NF}' | tee $RECURSIVE_DNS; done

echo "FILES CREATED:"
echo "> $NSLOOKUP"
echo "> $OUTFILE"
echo "> $RECURSIVE_DNS"

