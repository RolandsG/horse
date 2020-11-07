#!/bin/bash -ex

# Update to latest version
apt-get update -y && apt-get upgrade -y

# Make sure that Ansible is installed
apt install -y software-properties-common
apt-add-repository --yes ppa:ansible/ansible
apt install -y ansible

# Make sure Git is installed
apt install -y git

# Clone an Ansible playbook
git clone https://github.com/RolandsG/espooplaybooks.git /tmp/ansible/

# Execute playbook on local machine
cd /tmp/ansible
ansible-playbook --connection=local --inventory 127.0.0.1, install-nginx.yaml
ansible-playbook --connection=local --inventory 127.0.0.1, install-awscli.yaml

# Create output file
nginx -v 2>> output.txt
cd ..

AWS S3 output .frontend

# Increasing clarity script needed to log static files stored


