# APR 2022: Running Docker w/o installing AWS CLI
alias aws="docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli"

# Detach Policies from user/group
GET_POLICY_ARN=$(aws iam list-attached-group-policies --group-name deltaprotect-iam-audit-group \
		| grep 'policy/deltaprotect-iam-audit-policy' | sed 's/:/ /g' | awk '{print $5}') && \
		echo '[+] 1/7: Getting AWS POLICY_ARN'
aws iam detach-group-policy --group-name deltaprotect-iam-audit-group \
		--policy arn:aws:iam::aws:policy/job-function/ViewOnlyAccess && \
		echo "[+] 2/7: Detached ViewOnlyAccess from group" || echo "[-] ERROR"
aws iam detach-group-policy --group-name deltaprotect-iam-audit-group \
		--policy arn:aws:iam::aws:policy/SecurityAudit && \
		echo "[+] 3/7: Detached SecurityAudit from group" || echo "[-] ERROR"

# Delete Access Key
GET_ACCESS_KEY_ID=$(aws iam list-access-keys --user-name deltaprotect \
		| grep AccessKeyId | sed 's/"/ /g' | awk '{print $3}')
aws iam delete-access-key --access-key-id $GET_ACCESS_KEY_ID --user-name deltaprotect && \
		echo "[+] 4/7: ACCESS KEY - Deleted" || echo "[-] ERROR"

# Detach user from Group
aws iam remove-user-from-group --user-name deltaprotect \
		--group-name deltaprotect-iam-audit-group && \
		echo "[+] 5/7: Detached User from Group" || echo "[-] ERROR"

# Delete Group & User
aws iam delete-group --group-name deltaprotect-iam-audit-group && \
		echo "[+] 6/7: Deleted Group"  || echo "[-] ERROR"
aws iam delete-user --user-name deltaprotect && \
		echo "[+] 7/7: Deleted User" || echo "[-] ERROR"
