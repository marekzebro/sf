# SF task

## Objective
Automate the deployment and update process for a Polkadot Fullnode using Terraform and Ansible.

## Task Requirements
- [x] Create a repository on GitLab or GitHub for version control and collaboration.
- [x] Use Terraform to create IAC files for provisioning two instances on your preferred provider (for example on AWS). You can find the requirements of a Polkadot node [here](https://wiki.polkadot.network/docs/maintain-guides-how-to-validate-polkadot#reference-hardware)
- [x] Write an Ansible playbook to automate the deployment of the Polkadot binary v1.0.0 to the two instances. You can find information on it [here](https://wiki.polkadot.network/docs/maintain-guides-how-to-validate-polkadot#installing-the-polkadot-binary). The easiest way would be to take the pre-built binary provided. If you want to be fancy, you could build it yourself inside the playbook, though this is not required.
- [x] Configure the playbook to create and manage a systemd service file that will run the Polkadot Fullnode.
- [x] Write a brief description explaining how you would update the Polkadot nodes to v1.2.0 using your playbook

## Description 
For tasks outlined above I have chosen AWS, just because of my familiarity with their services. Instances would be created in `Europe(Frankfurt) eu-central-1` but this can be adjusted to any other location. PolkaDot requirements page states that a Debian based OS as the best choice. For this reason I picked an AMI image available in the region `ami-042e6fdb154c30c5`. Just for testing purposes I used `t2.micro` instances, however documentation recommends `c6i.4xlarge` instances instead. 

## Prerequisities
- A working AWS account with API credentials saved in `credentials` file in project directory, it should be in a format as per example below:
```
[default]
aws_access_key_id = abc
aws_secret_access_key = xyz
```   
- SSH key pair called `aws` for accessing instances, exported and saved as `aws.pem` in project directory. [docs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html)
- Downloaded Ansible & Terraform binaries

## Usage
To create instances running on AWS, following commands should be run
```
terraform init
terraform apply
```
This would create two instances `polka0` & `polka1` and display their addresses. After successful instance creation, add hosts to `hosts` file. 

Now run ansible playbook to configure instances
```
ansible-playbook -i hosts main.yml
```

Alternatively execute both tasks with helper script
```
./run.sh
```

## Upgrade process
Upgrading polkadot package version could be achieved by running ansible playbook with `polkadot_version` variable specified.

This example would install version `1.0.2` as long it is available.
```
ansible-playbook -i hosts main.yml --extra-vars 'polkadot_version=1.0.2'
```