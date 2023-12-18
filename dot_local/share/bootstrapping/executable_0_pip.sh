#!/bin/bash

source "$(dirname $0)/_utility.sh"
exit_if_installed pip


if [ "$OS" = "linuxmint" ]; then
  sudo apt update
  sudo apt install python3-pip    
fi

if [ "$OS" = "fedora" ]; then
  dnf check-update -y
  sudo dnf -y install python3-pip 
fi


