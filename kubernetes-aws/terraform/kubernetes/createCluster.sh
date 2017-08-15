#!/bin/bash

set -u
AWS_ZONES="us-east-2a,us-east-2b,us-east-2c"

kops create cluster \
--name jirawat.kubectl.io \
--api-loadbalancer-type public \
--associate-public-ip=false \
--bastion=true \
--channel stable \
--cloud aws \
--cloud-labels "Org=jirawat.com,Project=kubectl.io" \
--dns public \
--master-size c4.large \
--master-tenancy default \
--master-volume-size 70 \
--master-zones $AWS_ZONES \
--networking calico \
--node-count 3 \
--node-size m4.large \
--node-tenancy default \
--node-volume-size 70 \
--out tmpout \
--target terraform \
--topology private \
--zones $AWS_ZONES \
--yes \
--state s3://jirawat-kubectl-io-state-store

