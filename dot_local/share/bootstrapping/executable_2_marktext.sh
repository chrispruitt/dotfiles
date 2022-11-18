#!/bin/bash

source "$(dirname $0)/_utility.sh"

exit_if_installed_appimage marktext

set -e

if [ "$OS" = "fedora" ]; then
  curl -L https://github.com/marktext/marktext/releases/download/v0.17.1/marktext-x86_64.AppImage -o /tmp/marktext.AppImage
  chmod +x /tmp/marktext.AppImage
  install-appimage /tmp/marktext.AppImage
fi
