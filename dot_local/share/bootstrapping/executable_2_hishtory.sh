#!/bin/bash

source "$(dirname $0)/_utility.sh"
exit_if_installed hishtory

set -e

# install the binary
VERSION=$(curl -sfL https://api.github.com/repos/ddworken/hishtory/releases/latest | jq -r '.tag_name' | sed 's/v//g')
KERNEL=$(uname -s)
MACHINE=$(uname -m)
DOWNLOAD_URL="https://github.com/ddworken/hishtory/releases/download/v${VERSION}/hishtory-${KERNEL}-amd64"

curl -sfL $DOWNLOAD_URL -o $HOME/.local/bin/hishtory
chmod +x $HOME/.local/bin/hishtory

# install the zsh hooks
(
  cd /tmp/
  curl -sfLo - https://github.com/ddworken/hishtory/archive/refs/tags/v${VERSION}.tar.gz | tar -xzf - hishtory-${VERSION}/client/lib/config.zsh
  mkdir -p $HOME/.hishtory
  mv hishtory-${VERSION}/client/lib/config.zsh $HOME/.hishtory/
)

# TODO: init hishtory by setting your server and use your existing hishtory secret
# HISHTORY_SERVER=https://hishtory.cpru.net hishtory init $(gopass -o cpru/hishtory_secret)

# add the following to your zshrc
# eexport HISHTORY_SERVER=https://hishtory.cpru.net
# source /home/cpruitt/.hishtory/config.zsh


