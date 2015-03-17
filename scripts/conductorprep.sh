#!/bin/bash

### Determine the OS of the machine acting as conductor

if [ "$(uname)" == "Darwin" ]; then
    OS=OSX
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
fi

### Now we install everything the conductor needs

## Mac OSX prep
if [ $OS == OSX ]; then

  # Install everything we need for an OSX-based conductor
  ./conductinst-osx.sh

## Ubuntu prep
elif [ $OS == Ubuntu ]; then

  # Install everything we need for an Ubuntu-based conductor
  ./conductinst-ubu.sh

fi
