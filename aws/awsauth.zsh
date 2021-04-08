export SAML2AWS_MFA_TOKEN=$(2fa $PASS_NAME) 
export SAML2AWS_PASSWORD=$(gopass show $PASS_NAME | head -1) 


_awsauth() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  WORDS="$(cat ~/.saml2aws | grep "^\[" | sed 's/\[//;s/\]//')"
  case "$cur" in
    *)
      COMPREPLY=($(compgen -W "$WORDS" -- "$cur"))
      ;;
  esac
}

awsauth () {
	SAML_PROFILE=$1 
	export AWS_PROFILE=$(cat ~/.saml2aws | grep -A20 "$SAML_PROFILE" | grep aws_profile | awk '{print $3}' | head -1) 
	export AWS_REGION=$(cat ~/.saml2aws | grep -A20 "$SAML_PROFILE" | grep region | awk '{print $3}' | head -1) 
	export SAML2AWS_MFA_TOKEN=$(2fa $PASS_NAME) 
	export SAML2AWS_PASSWORD=$(gopass show $PASS_NAME | head -1) 
	saml2aws login --idp-account $SAML_PROFILE --skip-prompt
}

complete -F _awsauth awsauth