#!/bin/sh

curl -LO https://releases.hashicorp.com/terraform/0.10.0/terraform_0.10.0_linux_amd64.zip
curl -LO https://releases.hashicorp.com/packer/1.0.3/packer_1.0.3_linux_amd64.zip

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
curl -LO https://github.com/kubernetes/kops/releases/download/1.7.0/kops-linux-amd64
