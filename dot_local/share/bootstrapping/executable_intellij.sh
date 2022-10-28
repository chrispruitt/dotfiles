# source "$(dirname $0)/_utility.sh"

# # limit this to desktop environments
# exit_if_not_desktop

# exit_if_installed idea

# set -e


# if [ "$OS" = "fedora" ]; then
#   # enable flatpak
#   sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  
#   # install slack
#   sudo flatpak install -y flathub com.slack.Slack
#   sudo flatpak install -y flathub com.jetbrains.IntelliJ-IDEA-Ultimate

#   # enable idea command

#   echo todo figure out idea command
#   # sudo mkdir -p /app/extra/idea-IU/bin
#   # sudo ln -s /var/lib/flatpak/app/com.jetbrains.IntelliJ-IDEA-Ultimate/x86_64/stable/active/files/extra/idea-IU/bin/idea.sh /app/extra/idea-IU/bin/idea.sh
#   # add alias to .bashrc - alias idea="/var/lib/flatpak/app/com.jetbrains.IntelliJ-IDEA-Ultimate/x86_64/stable/active/files/bin/idea &"
# fi

