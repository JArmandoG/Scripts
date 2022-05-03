#!/bin/bash
ACCOUNT_B_GROUP_NAME='auditor-crossAccount' # Already Existing Group
ACCOUNT_B_POLICY_FILE='sl-policy.json' # Created by script B-0

aws --profile default iam put-group-policy \
		--group-name $ACCOUNT_B_GROUP_NAME \
		--policy-name Smart-assumeRole \
		--policy-document file://$ACCOUNT_B_POLICY_FILE && echo "Success 1"

ACCOUNT_B_POLICY_JSON=$(cat $ACCOUNT_B_POLICY_FILE)
ACCOUNT_A_ID=$(echo $ACCOUNT_B_POLICY_JSON | sed 's/"//g' | sed 's/ /\n/g' | grep arn | sed 's/:/ /g' | awk '{print $4}')
ACCOUNT_A_ROLE_NAME='assumeRole-Role' # Audited account's trusting Role
ACCOUNT_B_SESSION_NAME='smart-test-session'
aws --profile CrossAccountViewer sts assume-role --role-arn arn:aws:iam::$ACCOUNT_A_ID:role/$ACCOUNT_A_ROLE_NAME --role-session-name $ACCOUNT_B_SESSION_NAME
