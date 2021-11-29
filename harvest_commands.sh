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
# Copy hosts into a new file with format [domain]:[IP associated]

# ...

# Extract hosts only:
cat harvested.txt | sed 's/:/ /' | awk '{print $1}'
# Extract ONLY ALIVE hosts:
cat harvested.txt | sed 's/:/ /' | awk '{print $1}' | httprobe
# Convert doc with http domains to domains only:
sed 's/.*:\/\///' org_domains.txt >> org_domains_only.txt
# Extract IP from domain-only file:
for line in $(cat org_domains_only.txt | sed 's/.*:\/\///' ); do nslookup $line | grep -Ev '10.211.55.1' | grep Address | sed 's/Address: //' ; done
# Origin domains (AWS, GCP, etc.) per IP
for line in $(cat org_domains_only.txt | sed 's/.*:\/\///' ); do nslookup $line | grep -Ev '10.211.55.1' | grep Address | sed 's/Address: //' ; done | nslookup | grep 'name =' | awk '{print $NF}'
