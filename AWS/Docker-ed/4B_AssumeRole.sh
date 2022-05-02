# Usage: Mount $pwd in order to pass a JSON file as argument for AWS
AWS_ARGS='sts assume-role --role-arn arn:aws:iam::606197286729:role/TEST_CLI_CrossAccount --role-session-name mySession'

docker run --rm -it -v /Users/jarmando/Documents/AWS_DEMO:/root -v ~/.aws:/root/.aws amazon/aws-cli $AWS_ARGS

