import csv
import json
'''
1. EXTRACT A JSON FILE FROM BLOODHOUND IN "COMPUTERS WITH UNSUPPORTED OS" AND PROCESS IT TO 
GET A CSV WITH OS, SAM ACCOUNT NAME, WHETHER IT'S A HIGH VALUE TARGET OR NOT, AND THE DNSNAME OF EACH MACHINE

2. Do a JQ for counting each occurrence (How many Windows XP, etc.) with:

    jq -r '.nodes[].props.operatingsystem' old_computers.json | sort | uniq -c

'''

# VARIABLES
JSON_FILE = ''
OUTPUT_CSV = ''

### IMPORTING JSON & PROCESSING

with open(JSON_FILE) as f:
    data = json.load(f)

targets = []
for node in data['nodes']:
    target = {}
    target['DNSName'] = node['label']
    target['OperatingSystem'] = node['props']['operatingsystem']
    target['SAMAccountName'] = node['props']['samaccountname']
    target['HighValue'] = node['props']['highvalue']
    targets.append(target)

with open(OUTPUT_CSV, 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=['OS', 'DNSName', 'HighValue', 'SAMAccountName'])
    writer.writeheader()

    for machine in targets:
        writer.writerow({'OS': machine['OperatingSystem'], 'DNSName': machine['DNSName'], 'HighValue': machine['HighValue'], 'SAMAccountName': machine['SAMAccountName']})

