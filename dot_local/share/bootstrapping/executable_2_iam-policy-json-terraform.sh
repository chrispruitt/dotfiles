#!/bin/bash

source "$(dirname $0)/_utility.sh"
exit_if_installed iam-policy-json-to-terraform

set -e

VERSION=$(curl -sfL https://api.github.com/repos/flosell/iam-policy-json-to-terraform/releases/latest | jq -r '.tag_name' | sed 's/v//g')
DOWNLOAD_URL="https://github.com/flosell/iam-policy-json-to-terraform/releases/download/${VERSION}/iam-policy-json-to-terraform_amd64"

curl -L ${DOWNLOAD_URL} -o ${HOME}/.local/bin/iam-policy-json-to-terraform
chmod +x ${HOME}/.local/bin/iam-policy-json-to-terraform
