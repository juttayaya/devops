Initial One-time Setup Steps

Setup SSH Keys
1.) Setup ssh private keys on installation master server 
If the file ~/.ssh/id_rsa does not exist, then run the command
$ ssh-keygen -t rsa -b 2048

Accept all defaults at the prompts.

2.) Setup ssh authorized_keys on the remote managed servers
View the content of ~/.ssh/id_rsa.pub on the installation master server
For each remote managed server, ssh into the remote managed server as the remote username

Append the content of the installation master server
~/.ssh/id_rsa.pub to the file ~/.ssh/authorized_keys on the remote managed server

If the file  ~/.ssh/authorized_keys does not exist on the remote managed server, create it with the commands:
$ cp /dev/null ~/.ssh/authorized_keys
$ chmod 600  ~/.ssh/authorized_keys 

3.) Test the remote ssh works
For example, if the remote managed server hostname is server01 and the remote username is username123,
then run the command:

$ ssh username123@server01 hostname

Verify that you do not have to type in a password and the output is the remote hostname

Python setup
TODO
If Python issues install
sudo yum install -y PyYAML
sudo yum install -y python-simplejson
sudo yum install -y Jinja2
sudo yum install -y httplib2
sudo yum install -y six
sudo yum install -y paramiko

on Control Server

and

sudo yum install -y python-simplejson

on remote server
