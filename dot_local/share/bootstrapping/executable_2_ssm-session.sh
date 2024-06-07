#!/bin/bash

source "$(dirname $0)/_utility.sh"
exit_if_installed ssm-session

set -e

VERSION=$(curl -sfL https://api.github.com/repos/chrispruitt/ssm-session/releases/latest | jq -r '.tag_name' | sed 's/v//g')
KERNEL=$(uname -s)
MACHINE=$(uname -m)
DOWNLOAD_URL="https://github.com/chrispruitt/ssm-session/releases/download/${VERSION}/ssm-session_${KERNEL}_${MACHINE}.tar.gz"

curl -sfLo - $DOWNLOAD_URL | tar -xzf - -C ~/.local/bin ssm-session
