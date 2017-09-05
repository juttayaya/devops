#!/bin/bash

set -u

DEVOPS_DIR="src/devops"

git config --global user.name "juttayaya"
git config --global user.email "admin@apps.jirawat.com"
git config --global push.default simple
mkdir -p ${DEVOPS_DIR}
cd ${DEVOPS_DIR}
git init
git pull https://github.com/juttayaya/devops.git
git remote add origin https://github.com/juttayaya/devops.git
git push --set-upstream origin master

