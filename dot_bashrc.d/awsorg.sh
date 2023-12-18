export AWS_ORG_CONFIG_FILE_PREFIX=config-
export AWS_ORG_CREDENTIALS_FILE_PREFIX=credentials-

awsorg() {
  local org=$1

  if [[ -z "$org" ]]; then
    unset AWS_ORG
    unset AWS_CONFIG_FILE
    unset AWS_SHARED_CREDENTIALS_FILE
    unset AWS_DEFAULT_SSO_START_URL
    unset AWS_DEFAULT_SSO_REGION

  else
    export AWS_ORG=$org
    export AWS_CONFIG_FILE=~/.aws/${AWS_ORG_CONFIG_FILE_PREFIX}$org
    export AWS_SHARED_CREDENTIALS_FILE=~/.aws/${AWS_ORG_CREDENTIALS_FILE_PREFIX}$org
    export AWS_DEFAULT_SSO_START_URL=https://$org.awsapps.com/start
    export AWS_DEFAULT_SSO_REGION=us-east-1
  fi
}

_awsorg() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  WORDS="$(ls ~/.aws/ | grep ${AWS_ORG_CONFIG_FILE_PREFIX})"
  WORDS=${WORDS//${AWS_ORG_CONFIG_FILE_PREFIX}/}
  case "$cur" in
  *)
    COMPREPLY=($(compgen -W "$WORDS" -- "$cur"))
    ;;
  esac
}

complete -F _awsorg awsorg

awsorg-add() {
  mkdir -p ~/.aws
  touch ~/.aws/${AWS_ORG_CONFIG_FILE_PREFIX}${1}
  touch ~/.aws/${AWS_ORG_CREDENTIALS_FILE_PREFIX}${1}
}

awsorg-rm() {
  rm ~/.aws/${AWS_ORG_CONFIG_FILE_PREFIX}${1}
  rm ~/.aws/${AWS_ORG_CREDENTIALS_FILE_PREFIX}${1}
}

awsorg-populate-profiles() {
  aws-sso-util configure populate -u https://${AWS_ORG}.awsapps.com/start --sso-region us-east-1 --region us-east-1 -c output=json --no-credential-process
}

complete -F _awsorg awsorg-rm
