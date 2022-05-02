# APR 2022: Running Docker w/o installing AWS CLI
alias aws="docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli"

export AWS_DEFAULT_PROFILE=default
export ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' | tr -d '"')
# Keep the deltaprotect-iam-audit-policy.json in the current folder:

# Create Group and user + Add user to Group
aws iam create-user --user-name deltaprotect && \
aws iam create-group --group-name deltaprotect-iam-audit-group && \
aws iam add-user-to-group --user-name deltaprotect --group-name deltaprotect-iam-audit-group

# Attach policies to Group
aws iam attach-group-policy --group-name deltaprotect-iam-audit-group --policy-arn arn:aws:iam::aws:policy/SecurityAudit
aws iam attach-group-policy --group-name deltaprotect-iam-audit-group --policy-arn arn:aws:iam::aws:policy/job-function/ViewOnlyAccess

# Deploy Access Key for User
GET_SECRETACCESS_KEY=$(aws iam create-access-key --user-name deltaprotect | grep SecretAccessKey | sed 's/"/ /g' | awk '{print $3}')

GET_ACCESS_KEY_ID=$(aws iam list-access-keys --user-name deltaprotect | grep AccessKeyId | sed 's/"/ /g' | awk '{print $3}')


BLUE='\033[0;34m'
NO_COLOR='\033[0m'
echo
echo "
	Elements created:

	[+] GROUP	deltaprotect-iam-audit-group
	[+] USER	deltaprotect
	-----------------------------------------------
	[+] KEY ID:	${BLUE}$GET_ACCESS_KEY_ID${NO_COLOR}
	[+] KEY:	${BLUE}$GET_SECRETACCESS_KEY${NO_COLOR}
	"

unset ACCOUNT_ID AWS_DEFAULT_PROFILE

