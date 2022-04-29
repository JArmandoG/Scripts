#!/usr/bin/bash

DOMAIN=$1
OUTFILE=$1.subdomains
HTTPROBED=$1.subdomains.httprobed
NSLOOKUP=$1.subdomains.nslookupIPs
RECURSIVE_DNS=$1.subdomains.nslookup.recursive
DOMAIN_LIST=$(curl https://sonar.omnisint.io/subdomains/$DOMAIN | jq . | sort | uniq)

aggregator () {
		let $domain = $1
		CLEAN_DOMAIN=$domain | sed 's/\"//g' | tr -d \",\"
		echo $CLEAN_DOMAIN
}

aggregator $DOMAIN_LIST
for domain in $DOMAIN_LIST; do aggregator $domain; done
