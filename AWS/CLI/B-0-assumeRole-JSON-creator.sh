#!/bin/sh

# Output File (Modify this for a recognizable policy file - Or automate the process; this file name will be needed by the assumeRole script)
POLICY_FILE="sl-policy.json"

# Argument checker
if [ $# -eq 0 ]
  then
    echo "USAGE: assumeRole_creator.sh <TRUSTING-ACCOUNT-ID>"
	exit 1
fi

# Processing argument & building JSON object
ROLE_ARN=$1
json=$(cat <<-END
    {
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": ["sts:AssumeRole"],
    "Resource": "$ROLE_ARN"
  }]
    }
END
)

# (Writing JSON to a new file)
echo $json > $POLICY_FILE
