echo 'Updating gnupg configs for mac passphrase managment'
grep -qxF "pinentry-program /usr/local/bin/pinentry-mac" ~/.gnupg/gpg-agent.conf || echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
