#!/bin/sh

set -u
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

KP_NAME=jirawat-devops-keypair
AWS_REGION="us-east-1"

aws ec2 create-key-pair --key-name $KP_NAME --region $AWS_REGION --query 'KeyMaterial' --output text > ${KP_NAME}.pem
chmod 400 ${KP_NAME}.pem
