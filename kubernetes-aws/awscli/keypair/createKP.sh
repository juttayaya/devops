#!/bin/sh

aws ec2 create-key-pair --key-name k8s-keypair --region us-east-2 > k8s-keypair.out
