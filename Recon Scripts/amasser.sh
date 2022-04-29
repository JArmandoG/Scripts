#!/bin/bash

# Usage: amasser.sh domain.com

# Input: domain name
# get output file from amass domain:ip and other results and only look for domains/subdomains, then probe for 
# response and write a new file
# (The output of amass is > domain ip,ip,ip)
#
# Note: This could be also useful for any input file containing domains/subdomains
#
DOMAIN=$1 # example.com
AMASS_FILE=$DOMAIN.amassenum # amass_outfile.txt (I normally use the format domain.com.amassenum for organization)
# Automatically enumerate with amass
amass enum -ip -d $DOMAIN | tee $AMASS_FILE
#
cat $AMASS_FILE | grep $DOMAIN | awk '{print $1}' | httprobe | tee $AMASS_FILE.httprobed
# Then:
# (Clean http/https probes and sort results)
sleep 1
echo "------------------------------------------------"
cat $AMASS_FILE.httprobed | sed 's/http.*:\/\///g' | sort | uniq | tee $DOMAIN.amassenum.hosts

# TO-DO: Automate this and use only 1 output file instead of writing a file and reading it agan, 
# then writing another one. 
# But *.httprobed could be useful to see what methods the hosts accept
echo "[+] Files generated:"
echo $AMASS_FILE
echo $DOMAIN.amassenum.hosts
echo $AMASS_FILE.httprobed
