function dovpn () {
    export OPENVPN_PROFILE=${OPENVPN_PROFILE:-"default"}
    if [ -e "$HOME/.openvpn/${OPENVPN_PROFILE}.ovpn" ]
    then
        openvpncmd="--config  ~/.openvpn/${OPENVPN_PROFILE}.ovpn"
    else
        echo "Profile ${OPENVPN_PROFILE} not found ($HOME/.openvpn/${OPENVPN_PROFILE}.ovpn)"
        return 1
    fi
    MFA=$(2fa "$OPENVPN_PASS")
    CREDS=$(mktemp ~/vpn.creds.XXXXXXXX)
    chmod 600 $CREDS
    gopass show "$OPENVPN_PASS" > $CREDS
    echo $CREDS
    bash -c "sleep 30; rm -rf $CREDS" &
    sudo vpn $HOME/.openvpn/$OPENVPN_PROFILE.ovpn $MFA $CREDS
}