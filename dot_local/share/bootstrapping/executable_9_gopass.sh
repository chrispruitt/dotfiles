#!/bin/bash

source "$(dirname $0)/_utility.sh"

# limit this to desktop environments
exit_if_not_desktop

exit_if_installed gopass

set -e

if [ "$OS" = "manjaro" ]; then
  sudo pacman -S gopass gopass-jsonapi
fi

if [ "$OS" = "fedora" ]; then
    sudo yum install -y gopass gopass-jsonapi
fi

yes | gopass-jsonapi configure --browser chrome --global=false --path ~/.config/gopass
