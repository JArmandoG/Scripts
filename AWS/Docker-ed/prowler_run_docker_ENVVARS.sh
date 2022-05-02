AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
CHECKS='' # -g hipaa, -c check42, etc.
OUT_FOLDER=$(pwd)
OUT_FORMAT='csv'

docker run -ti --rm -v $OUT_FOLDER:/prowler/output --name prowler --env $AWS_ACCESS_KEY_ID --env $AWS_SECRET_ACCESS_KEY --env AWS_SESSION_TOKEN toniblyx/prowler:latest $CHECKS -M $OUT_FORMAT

