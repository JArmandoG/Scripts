#!/bin/bash
#
POLICY_FILE_CONTENT=$(cat <<-END
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "$ACCOUNT_ID"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
        }
    ]
}
END
)
echo $POLICY_FILE_CONTENT > trustPolicy.json

ROLE_NAME='assumeRole-Role'
SESSION_DURATION='43200'
POLICY_DOCUMENT='trustPolicy.json'

aws iam create-role \
		--assume-role-policy-document file://$POLICY_DOCUMENT \
		--max-session-duration $SESSION_DURATION \
		--role-name $ROLE_NAME \
		--permissions-boundary arn:aws:iam::aws:policy/job-function/ViewOnlyAccess \
		&& \
		aws iam attach-role-policy \
			--role-name $ROLE_NAME \
			--policy-arn arn:aws:iam::aws:policy/job-function/ViewOnlyAccess && \
			echo "[+] 1/1 SUCCESS CREATING $ROLE_NAME"


# Get Role's ARN:
ROLE_ARN=$(aws iam list-roles | grep assumeRole-Role | grep Arn | sed 's/"//g' | sed 's/,//' | awk '{print $2}')

echo "------------------------"
echo "[i] Role ARN: $ROLE_ARN"

rm trustPolicy.json && echo "Deleted JSON file"