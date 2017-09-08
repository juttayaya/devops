Creates a "Master Control" servers with all the software necessary to administer
a modern DevOps environment.

Installs the following software
------------
packer

terraform

ansible

docker

kubectl

kops

git

Step 1: Download software artifacts to install

cd packer/software-repository

./downloadArtifacts.sh

Step 2: Use packer to create the server image

cd packer

packer build devops-master-control.json

Step 3: Use terraform te create a server from the image

cd terraform

terraform apply
