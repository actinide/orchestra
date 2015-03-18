#!/bin/bash
#
# Installs everything we need for a machine running Mac OSX to act
# as the conductor.


# Install Homebrew
if test ! $(which_brew); then
  echo $BLUE'==>'$RESET "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew update
fi

# Install Packer
if test ! $(which_packer); then
  echo $BLUE'==>'$RESET "Installing Packer..."
  brew tap homebrew/binary
  brew install packer
fi

# Install Ansible
if test ! $(which_ansible); then
  echo $BLUE'==>'$RESET "Installing Ansible..."
  brew install ansible
fi

# Install and/or update Python
brew install python

# Install AWS command line tools
if test ! $(which_aws); then
  echo $BLUE'==>'$RESET "Installing AWS command line tools..."
fi

# Install EC2 command line tools
if [ ! -d /usr/local/ec2 ]; then
  echo $BLUE'==>'$RESET "Installing EC2 CLI tools..."
  curl -O http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
  mkdir /usr/local/ec2
  unzip ec2-api-tools.zip -d /usr/local/ec2
  rm ec2-api-tools.zip
fi

# Install Java
# This is a to-do item.
