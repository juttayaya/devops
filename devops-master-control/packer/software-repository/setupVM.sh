#!/bin/bash -x

set -u
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

REPO=/tmp/repo
CTRL_USER=masterctrl
CTRL_HOME=/home/${CTRL_USER}
HASHICORP_DIR=${CTRL_HOME}/hashicorp/bin
K8S_DIR=${CTRL_HOME}/k8s/bin
SETUP_GIT="setupGit.sh"
source ${REPO}/common_ver.sh

useradd ${CTRL_USER}

## Git
yum install -y git
mv ${REPO}/${SETUP_GIT} ${CTRL_HOME}
chmod 700 ${CTRL_HOME}/${SETUP_GIT}

## Docker
yum install -y docker
usermod -a -G docker ec2-user
usermod -a -G docker ${CTRL_USER}

## Kubernetes
mkdir -p ${K8S_DIR}
mv ${REPO}/${KOPS_BIN} ${K8S_DIR}/${KOPS}
chmod 700 ${K8S_DIR}/${KOPS}
mv ${REPO}/${KUBECTL_BIN} ${K8S_DIR}/${KUBECTL}
chmod 700 ${K8S_DIR}/${KUBECTL}

## Hashicorp (packer, terraform)
mkdir -p ${HASHICORP_DIR}
cd ${HASHICORP_DIR}
unzip ${REPO}/${PACKER_ZIP}
unzip ${REPO}/${TERRAFORM_ZIP}
chown 700 *

## Ansible
cd ${CTRL_HOME}
unzip ${REPO}/${ANSIBLE_ZIP}

## Bashrc
cat <<EOF >> ${CTRL_HOME}/.bashrc
source \${HOME}/${ANSIBLE}/hacking/env-setup
export PATH=${HASHICORP_DIR}:${K8S_DIR}:\${PATH}
EOF

chmod 600 ${CTRL_HOME}/.bashrc
chown -R ${CTRL_USER}. ${CTRL_HOME}
