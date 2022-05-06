aws iam detach-role-policy --role-name assumeRole-Role --policy-arn arn:aws:iam::aws:policy/job-function/ViewOnlyAccess && echo "[+] 1/2 Successfully dettached policy from role" || echo "[-] Failure dettaching policy from role"

aws iam delete-role --role-name assumeRole-Role && \
	echo "[+] 2/2 Successfully deleted role from the acocunt" || echo "[-] Failure deleting role from the account"
	