#!/bin/bash

source "$(dirname $0)/_utility.sh"
exit_if_installed code

set -e

if [ "$OS" = "manjaro" ]; then
    yes | sudo pacman -Su vscode
fi

if [ "$OS" = "linuxmint" ]; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install code
fi

if [ "$OS" = "fedora" ]; then
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    dnf check-update -y
    sudo dnf install code -y
fi

# Install extensions
for item in \
      golang.go \
      hashicorp.terraform \
      ms-python.python \
      redhat.java \
      gabrielbb.vscode-lombok \
      esbenp.prettier-vscode \
      redhat.vscode-yaml \
      jkillian.custom-local-formatters \
      eamodio.gitlens \
      jebbs.plantuml \
      pkief.material-icon-theme \
      zhuangtongfa.Material-theme \
      tabnine.tabnine-vscode
do code --force --install-extension $item; done
