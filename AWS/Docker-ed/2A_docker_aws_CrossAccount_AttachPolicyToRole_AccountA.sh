# ADD A READ-ONLY POLICY FOR A ROLE

# How this works: Mount $pwd in order to pass a JSON file as argument for AWS
# AWS_ARGS='iam put-role-policy --role-name TEST_CLI_CrossAccount --policy-name ReadOnlyAccess-default --policy-document file:///root/ReadOnlyAccess.json'

AWS_ARGS='iam attach-role-policy --role-name TEST_CLI_CrossAccount --policy-arn arn:aws:iam::aws:policy/job-function/ViewOnlyAccess'

docker run --rm -it -v /Users/jarmando/Documents/AWS_DEMO:/root -v ~/.aws:/root/.aws amazon/aws-cli $AWS_ARGS

