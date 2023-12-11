#!/bin/bash
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"
msg () {
    echo -e "\n${GREEN}INFO [${1}] ${NC}\n"
}

for cmd in terraform ansible; do
    if ! command -v ${cmd} &> /dev/null
    then
        echo -e "\n${RED}ERROR [${cmd} binary cannot be found!]${NC}\n"
        exit 1
    fi
done


msg "Initialising terraform"
terraform init

msg "Applying terraform configuration"
terraform apply -auto-approve

msg "Saving host names"
terraform output | awk -F '"' '{print $2}' > hosts

msg "Running ansible playbook"
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook main.yml -i hosts