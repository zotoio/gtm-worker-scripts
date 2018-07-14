#!/bin/bash

PACKAGE=$1

echo 'Packaging ' $PACKAGE ' for release.';
cd /usr/workspace/clone/packages/$PACKAGE

source ./serverless-package-config.sh $PACKAGE "prod"

if grep -q "sls-package" ./package.json; then
    echo "found npm script for packaging release.."
    yarn sls-package >> ${OUT_FILE} 2>&1 || echo "failed $PACKAGE..";
    echo "release package created, uploading to s3://$S3_DEPENDENCY_BUCKET/releases/$PACKAGE"
    https_proxy=$AWS_S3_PROXY aws s3 cp /usr/workspace/clone/output/packages \
        s3://$S3_DEPENDENCY_BUCKET/releases/$PACKAGE/ --recursive --exclude "*" --include "$PACKAGE-*" --exclude "*/*"
    echo "release upload completed!"
else
    echo "npm script for packaging $PACKAGE is missing" >> ${OUT_FILE}
fi