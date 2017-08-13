#!/bin/sh -x

set -u

REPO=/tmp/repo
CTRL_USER=adminctrl
CTRL_HOME=/home/${CTRL_USER}
HASHICORP_BIN=${CTRL_HOME}/hashicorp/bin
K8S_BIN=${CTRL_HOME}/k8s/bin
KUBECTL=kubectl
KOPS=kops-linux-amd64
PACKER_ZIP=packer_1.0.4_linux_amd64.zip
TERRAFORM_ZIP=terraform_0.10.0_linux_amd64.zip
JAVA_ZIP=jdk-8u144-linux-x64.tar.gz
JAVA_NAME=jdk1.8.0_144
JAVA_DIR=${CTRL_HOME}/java
MVN_NAME=apache-maven-3.5.0
SETUP_GIT="setupGit.sh"

yum install -y git
yum install -y docker

useradd ${CTRL_USER}

usermod -a -G docker ec2-user
usermod -a -G docker ${CTRL_USER}

mkdir -p ${HASHICORP_BIN}
mkdir -p ${K8S_BIN}
mv ${REPO}/${KOPS} ${K8S_BIN}
chmod 700 ${K8S_BIN}/${KOPS}
mv ${REPO}/${KUBECTL} ${K8S_BIN}
chmod 700 ${K8S_BIN}/${KUBECTL}
mv ${REPO}/${SETUP_GIT} ${CTRL_HOME}
chmod 700 ${CTRL_HOME}/${SETUP_GIT}

cd ${CTRL_HOME}
tar xzpvf ${REPO}/${MVN_NAME}-bin.tar.gz

mkdir -p $JAVA_DIR
cd $JAVA_DIR
tar xzpvf ${REPO}/${JAVA_ZIP}

cd ${HASHICORP_BIN}
unzip ${REPO}/${PACKER_ZIP}
unzip ${REPO}/${TERRAFORM_ZIP}
chown 700 *

cat <<EOF >> ${CTRL_HOME}/.bashrc
export JAVA_HOME=${JAVA_DIR}/${JAVA_NAME}
export PATH=${HASHICORP_BIN}:${K8S_BIN}:${CTRL_HOME}/${MVN_NAME}/bin:\${JAVA_HOME}/bin:\${PATH}
EOF

chmod 600 ${CTRL_HOME}/.bashrc
chown -R ${CTRL_USER}. ${CTRL_HOME}
