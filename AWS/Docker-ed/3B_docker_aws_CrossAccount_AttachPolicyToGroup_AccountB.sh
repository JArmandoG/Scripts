# Usage: Mount $pwd in order to pass a JSON file as argument for AWS
AWS_ARGS='iam put-group-policy --group-name test-crossaccount --policy-name ACCOUNT-A-ASSUME-ROLE --policy-document file:///root/TrustingAccountPolicy.json'

docker run --rm -it -v /Users/jarmando/Documents/AWS_DEMO:/root -v ~/.aws:/root/.aws amazon/aws-cli $AWS_ARGS

