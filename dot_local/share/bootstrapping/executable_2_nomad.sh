#!/bin/bash

source "$(dirname $0)/_utility.sh"
exit_if_installed nomad

set -e

curl -sfLo - https://releases.hashicorp.com/nomad/1.5.2/nomad_1.5.2_linux_amd64.zip | busybox unzip -qd ~/.local/bin -
chmod +x ~/.local/bin/nomad
