# General Info

## Intro:

- trustPolicy.json must be modified to have the "auditor"'s account ID

# ACCOUNT A (TRUSTING ACCOUNT)
- Run `CreateRole.sh`, including the `trustPolicy.json` file - No more data needed by this account. Full Role ARN gets printed @ stdout & success/error flags will be printed in stdout

# ACCOUNT B (TRUSTED ACCOUNT)
- Receive the full **ARN** for the role (This ARN will include the Account A's ID as well as the name of the role)
- Run the `B-0.sh` json policy generator script with `policy_generator.sh <FULL-ARN>` - This will generate a policy in JSON and automatically fill the ARN "Resource" field
- Run the `B-1` attachPolicy.sh script - This will print the temporary credentials to stdout; take note of this fields
- Fill manually the `B-3` script with temp creds and run it -> This script can be reused and also run any AWS CLI command (Including Prowler)

# CLEANUP: ACCOUNT A (TRUSTING ACCOUNT)
- Run `Cleanup.sh` - this will automatically detach the policy from the Role, and delete the Role. Success/error flags will be printed in stdout
