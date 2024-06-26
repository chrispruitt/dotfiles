#!/bin/bash

source "$(dirname $0)/_utility.sh"
exit_if_installed aws

set -e

curl -sflo "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip -q awscliv2.zip
sudo ./aws/install --update
rm -rf aws awscliv2.zip

if [ "$OS" = "manjaro" ]; then
    # session manager plugin
    sudo pamac install aws-session-manager-plugin
fi

if [ "$OS" = "fedora" ]; then
  sudo yum install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm
fi
