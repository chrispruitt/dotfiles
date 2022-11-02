#!/bin/bash

# ddconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > ~/.config/system-keybindings.dconf

dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < ~/.config/system-keybindings.dconf