#!/bin/bash -x

MD_DIR="/opt/melissadata"
EFS_DIR="/efs-melissadata"
EFS_NAME="fs-16a64a6f.efs.us-east-2.amazonaws.com"

mkdir -p $EFS_DIR
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${EFS_NAME}:/ ${EFS_DIR}
echo "${EFS_NAME}:/ $EFS_DIR nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0" >> /etc/fstab

ln -s $EFS_DIR/melissadata_20170816 $MD_DIR
