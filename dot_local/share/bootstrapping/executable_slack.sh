source "$(dirname $0)/_utility.sh"

# limit this to desktop environments
exit_if_not_desktop

set -e

if [ "$OS" = "fedora" ]; then

  exit_if_installed_with_flatpak com.slack.Slack

  # enable flatpak
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  
  # install slack
  sudo flatpak install -y flathub com.slack.Slack
fi
