#Add the g2l-office.txt file with a list of ips for your dns config

function dns-setup-g2l-office() {
 local IPS=$(<~/.dotfiles/DNS/g2l-office.txt)
 IPS=$(echo ${value//$'\n'/ })

 local DNS_COMMAND="networksetup -setdnsservers Wi-Fi ${IPS}"
 echo ${DNS_COMMAND}
 eval ${DNS_COMMAND}
}

function dns-setup-default() {
 networksetup -setdnsservers Wi-Fi empty
}