#!/bin/bash
#
# Created @ Account that will be granting permissions ("Audited account")
#
# NOTA: CAMBIAR ARN:Usuario (Root, nombre del usuario en cuenta B)
#
ROLE_NAME='TEST_CLI_CrossAccount'
SESSION_DURATION='43200'
POLICY_DOCUMENT='trust-policy-A.json'

aws iam create-role \
		--assume-role-policy-document file://$POLICY_DOCUMENT \
		--max-session-duration $SESSION_DURATION \
		--role-name $ROLE_NAME \
		--permissions-boundary arn:aws:iam::aws:policy/job-function/ViewOnlyAccess \
		&& \
		aws iam attach-role-policy \
			--role-name $ROLE_NAME \
			--policy-arn arn:aws:iam::aws:policy/job-function/ViewOnlyAccess && \
			echo "Success"