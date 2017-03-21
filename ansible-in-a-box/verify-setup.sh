#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERIFY_SETUP_DIR="${SCRIPT_DIR}/verify-setup"
VERIFY_SETUP_HOSTS="${VERIFY_SETUP_DIR}/hosts"
VERIFY_SETUP_YML="${VERIFY_SETUP_DIR}/main.yml"
ANSIBLE_ARGS=""

function printUsage {
    local errMsg=$1
    local scriptName=`basename $0`
    if [ "X${errMsg}" != "X" ]; then
        echo "ERROR: $errMsg"
    fi
    echo "Description:"
    echo "    Verify that Ansible is setup correctly and working."
    echo "Usage:"
    echo "    $scriptName"
    echo "Example:"
    echo "    $scriptName"
    exit 1
}

######
# Main
######
while getopts ":a:h" opt; do
    case $opt in
      a)
        ANSIBLE_ARGS=$OPTARG
        ;;
      h)
        printUsage
        ;;
      \?)
        printUsage "Invalid option -$OPTARG"
        ;;
      :)
        printUsage "Option -$OPTARG requires argument"
        ;;
     esac
done

export ANSIBLE_CONFIG=$SCRIPT_DIR/ansible/ansible.cfg
source $SCRIPT_DIR/ansible/hacking/env-setup -q

ansible all -m ping -i ${VERIFY_SETUP_HOSTS} ${ANSIBLE_ARGS}

## Uncomment to see all available Ansible variables
#ansible all -m setup -i ${VERIFY_SETUP_HOSTS} ${ANSIBLE_ARGS

ansible-playbook ${VERIFY_SETUP_YML} -i ${VERIFY_SETUP_HOSTS} ${ANSIBLE_ARGS} 

