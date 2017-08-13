#!/bin/sh

curl -LO https://releases.hashicorp.com/terraform/0.10.0/terraform_0.10.0_linux_amd64.zip
curl -LO https://releases.hashicorp.com/packer/1.0.4/packer_1.0.4_linux_amd64.zip

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
curl -LO https://github.com/kubernetes/kops/releases/download/1.7.0/kops-linux-amd64

curl -LO http://www-eu.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz

# Download Java 8 at http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
