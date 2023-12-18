#!/bin/bash

source "$(dirname $0)/_utility.sh"

exit_if_installed zsh

set -e

if [ "$OS" = "fedora" ]; then
  sudo yum install -y zsh
fi

# set as default shell
echo "Change default shell to zsh."
chsh -s $(which zsh)