#!/bin/bash
#
# AssumeROle function in auditing account ("Account B")
# Reqs: Install JQ
# 
ACCOUNT_A_ROLE_NAME='TEST_CLI_CrossAccount'
ACCOUNT_A_ID='606197286729'

ACCOUNT_B_GROUP_NAME='test-crossAccount' # Already Existing Group
ACCOUNT_B_ROLE_NAME='Account_A_AssumeRole'
ACCOUNT_B_SESSION_NAME='MySession'
ACCOUNT_B_POLICY_FILE='assumeRole-policy-B.json' # *

aws --profile default iam put-group-policy \
		--group-name $ACCOUNT_B_GROUP_NAME \
		--policy-name ACCOUNT-A-ASSUME-ROLE \
		--policy-document file://$ACCOUNT_B_POLICY_FILE && echo "Success 1"

aws --profile CrossAccountViewer sts assume-role  \
		--role-arn arn:aws:iam::$ACCOUNT_A_ID:role/$ACCOUNT_A_ROLE_NAME \
		--role-session-name $ACCOUNT_B_SESSION_NAME | jq .
