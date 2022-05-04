#!/bin/sh

# HTML Body:
_HTML='''
'''

# Args:
# -xu username, -xp password, -s smtp.example.com:25, -f from@email.com, -t recipient@example.com -u message_subject
cat content.html | sendemail \
		-xu "" \
		-xp "" \
		-s "" \
		-f "" \
		-t $1 \
		-u "" 
