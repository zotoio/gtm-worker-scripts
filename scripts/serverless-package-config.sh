# collect config and write to files/env
PACKAGE=$1
STAGE=$2
echo "Collecting package configuration for $PACKAGE ($STAGE).."

aws ssm get-parameters-by-path --with-decryption --path /serverless/$PACKAGE/$STAGE

# aws ssm put-parameter --name "/serverless/sample-http/dev/SAMPLE_VAR" --type "String" --value "some value"