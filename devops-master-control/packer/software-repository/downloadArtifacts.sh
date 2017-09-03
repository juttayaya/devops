#!/bin/bash

set -u
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

source common_ver.sh

if [ ! -f "$TERRAFORM_ZIP" ]; then
    echo "Downloading ${TERRAFORM_ZIP}"
    curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/${TERRAFORM_ZIP}
else
    echo "Already downloaded ${TERRAFORM_ZIP}"
fi

if [ ! -f "$PACKER_ZIP" ]; then
   echo "Downloading ${PACKER_ZIP}"
   curl -LO https://releases.hashicorp.com/packer/${PACKER_VER}/${PACKER_ZIP}
else
   echo "Already Downloaded ${PACKER_ZIP}"
fi

if [ ! -f "${KUBECTL_BIN}" ]; then
   echo "Downloading ${KUBECTL_BIN}"
   curl -o ${KUBECTL_BIN} -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/amd64/kubectl
##curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
else
   echo "Already Downloaded ${KUBECTL_BIN}"
fi

if [ ! -f ${KOPS_BIN} ]; then
   echo "Downloading ${KOPS_BIN}"
   curl -o ${KOPS_BIN} -L https://github.com/kubernetes/kops/releases/download/${KOPS_VER}/${KOPS}
else
   echo "Already Downloaded ${KOPS_BIN}"
fi

if [ ! -f ${ANSIBLE_ZIP} ]; then
    echo "Downloading ${ANSIBLE_ZIP}"
    curl -o ${ANSIBLE_ZIP} -L https://github.com/ansible/ansible/archive/stable-${ANSIBLE_VER}.zip
else
   echo "Already Downloaded ${ANSIBLE_ZIP}"
fi
