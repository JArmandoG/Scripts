# Usage: Mount $pwd in order to pass a JSON file as argument for AWS
AWS_ARGS='iam create-role --assume-role-policy-document file:///root/CrossAccountPolicy.json --max-session-duration 86400 --role-name TEST_CLI_CrossAccount --permissions-boundary arn:aws:iam::aws:policy/job-function/ViewOnlyAccess'

docker run --rm -it -v /Users/jarmando/Documents/AWS_DEMO:/root -v ~/.aws:/root/.aws amazon/aws-cli $AWS_ARGS

