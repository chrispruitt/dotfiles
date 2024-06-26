#!/bin/bash

source "$(dirname $0)/_utility.sh"

# limit this to desktop environments
exit_if_not_desktop

exit_if_installed Typora

set -e

INSTALL_DIR=~/.local/share/typora

mkdir -p $INSTALL_DIR

curl -sfLo - https://typora.io/linux/Typora-linux-x64.tar.gz | tar -xzvf - -C $INSTALL_DIR --strip-components=2

ln -s ~/.local/share/typora/Typora ~/.local/bin/Typora

DEST_SHORTCUT="$HOME/.local/share/applications/typora.desktop"

cat << EOF > $DEST_SHORTCUT
[Desktop Entry]
Name=Typora
Exec=~/.local/share/typora/Typora
Icon=~/.local/share/typora/resources/assets/tile/OD-LargeTile.scale.png
Terminal=false
Type=Application
EOF
