#!/bin/bash

# Get All URLs excluding blacklisted file extensions
# Usage: gau.sh hosts-file.txt

BLACKLIST='png,jpg,jpeg,img,woff,woff1,woff2,svg,gif,mp4,mp3,css'
HOSTS=$1

for DOMAIN in $(cat $HOSTS); do echo $DOMAIN | gau --blacklist $BLACKLIST --from 202101 --to 202204 | tee $DOMAIN.gau; done
