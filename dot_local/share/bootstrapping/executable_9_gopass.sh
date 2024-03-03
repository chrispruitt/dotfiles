#!/bin/bash

source "$(dirname $0)/_utility.sh"

# limit this to desktop environments
exit_if_not_desktop

exit_if_installed gopass

set -e

if [ "$OS" = "manjaro" ]; then
  sudo pacman -S gopass gopass-jsonapi
fi

if [ "$OS" = "linuxmint" ]; then
  curl https://packages.gopass.pw/repos/gopass/gopass-archive-keyring.gpg | sudo tee /usr/share/keyrings/gopass-archive-keyring.gpg >/dev/null
  cat << EOF | sudo tee /etc/apt/sources.list.d/gopass.sources
Types: deb
URIs: https://packages.gopass.pw/repos/gopass
Suites: stable
Architectures: all amd64 arm64 armhf
Components: main
Signed-By: /usr/share/keyrings/gopass-archive-keyring.gpg
EOF
  sudo apt update
  sudo apt install gopass gopass-archive-keyring
  # TODO install gopass-jsonapi
fi

if [ "$OS" = "fedora" ]; then
    sudo yum install -y gopass gopass-jsonapi
fi

yes | gopass-jsonapi configure --browser chrome --global=false --path ~/.config/gopass
