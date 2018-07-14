#!/bin/bash

PACKAGE=$1

echo 'Packaging ' $PACKAGE ' for release.';
cd /usr/workspace/clone/packages/$PACKAGE

source ./serverless-package-config.sh $PACKAGE "prod"

if grep -q "sls-package" ./package.json; then
    yarn sls-package >> ${OUT_FILE} 2>&1 || echo "failed $PACKAGE..";
    https_proxy=$AWS_S3_PROXY aws s3 sync ../../output/packages/$PACKAGE-*.tar.gz s3://$S3_DEPENDENCY_BUCKET/releases/$PACKAGE 2>&1 || echo "failed uploading $PACKAGE..";
else
    echo "npm script for packaging $PACKAGE is missing" >> ${OUT_FILE}
fi