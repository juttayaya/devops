#!/bin/bash

# deleteBefore=`date --date="1 week ago" +%F`
bucket=$1
# fileToDelete=$2
fileName='/tmp/aws_delete.json'
rm $fileName
echo "Removing all versions of $fileToDelete from $bucket"
#versionsToDelete=`aws s3api list-object-versions --bucket "$bucket" --prefix "$fileToDelete" --query "Versions[?(LastModified<'$deleteBefore' && (contains(LastModified, 'T0') || contains(LastModified, 'T1') || contains(LastModified, 'T20') || contains(LastModified, 'T21') || contains(LastModified, 'T22')))].{Key: Key, VersionId: VersionId}"`
versionsToDelete=`aws s3api list-object-versions --bucket "$bucket"
cat << EOF > $fileName
{"Objects":$versionsToDelete, "Quiet":true}
EOF
aws s3api delete-objects --bucket "$bucket" --delete file://$fileName
# s3api delete-objects can handle upto 1000 records
echo "Delete successsful"
