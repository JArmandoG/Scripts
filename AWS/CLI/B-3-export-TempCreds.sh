export AWS_ACCESS_KEY_ID="ASIAUUYF4GK7BLQMKPF3"
export AWS_SECRET_ACCESS_KEY="+Bg9zvuuULSADL8LpUBSMk0mqhlv6zb2BSev2eQe"
export AWS_SESSION_TOKEN="FwoGZXIvYXdzEKX//////////wEaDHhZ//C04IDA5IBkxyKuAVYseMoWEcG12C5bxmG942lsYHCQECazAl+S8+fo0FKHfIrJDVYXsTclpFYfTE5X7P9Rx4Z4irkPBTnAOkl1M2l70xkE3mThI3EllsETmxswdjlKLaLi6o2IXtEr+bJoN4jS4xzi5TvA+XwbNjHjzWD/XRhYBFRJQxDFa7/cb/QG0Oo7EAXJgJYEGtzwU+y/Ybz0kTBJmO2rW8w99C/0DrcX8VxoZeTdkehAzxPNHCjFm8STBjItvyz58qcYPXeYMAmRsuN9HyTLCLX6hgh0A+IriJxceKXUhkW9XTZs0dZzn33r"

# PRUEBAS:
aws sts get-caller-identity

CHECKS='-c check42' # -g hipaa, -c check42, etc.
docker run -ti --rm --name prowler --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --env AWS_SESSION_TOKEN toniblyx/prowler:latest $CHECKS
