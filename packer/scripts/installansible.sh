#!/bin/bash

# Prep
export DEBIAN_FRONTEND=noninteractive
sudo apt-get dist-upgrade -y
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install python-pip python-dev -y

# Install
sudo pip install ansible
