#!/bin/sh -x

set -u

REPO=/tmp/repo
CTRL_USER=adminctrl
CTRL_HOME=/home/${CTRL_USER}
HASHICORP_BIN=${CTRL_HOME}/hashicorp/bin
K8S_BIN=${CTRL_HOME}/k8s/bin
KUBECTL=kubectl
KOPS=kops-linux-amd64
PACKER_ZIP=packer_1.0.3_linux_amd64.zip
TERRAFORM_ZIP=terraform_0.10.0_linux_amd64.zip


useradd ${CTRL_USER}
mkdir -p ${HASHICORP_BIN}
mkdir -p ${K8S_BIN}
mv ${REPO}/${KOPS} ${K8S_BIN}
chmod 700 ${K8S_BIN}/${KOPS}
mv ${REPO}/${KUBECTL} ${K8S_BIN}
chmod 700 ${K8S_BIN}/${KUBECTL}

cd ${HASHICORP_BIN}
unzip ${REPO}/${PACKER_ZIP}
unzip ${REPO}/${TERRAFORM_ZIP}
chown 700 *

cat <<EOF >> ${CTRL_HOME}/.bashrc
export PATH=${HASHICORP_BIN}:${K8S_BIN}:\${PATH}
EOF

chmod 600 ${CTRL_HOME}/.bashrc
chown -R ${CTRL_USER}. ${CTRL_HOME}
