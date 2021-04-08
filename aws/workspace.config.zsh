# '~/.aws/credentials' must exist to create workspaces

AWS_DIR="${HOME}/.aws"
AWS_WORKSPACE_DIR="${AWS_DIR}/.workspaces"

rm -rf ${AWS_WORKSPACE_DIR}
mkdir -p ${AWS_WORKSPACE_DIR}

while read line; do
    if [[ ${line} =~ "\\[.*\\]" ]]; then
      aws_env="$(echo ${line} | cut -d '[' -f2 | cut -d ']' -f1)"
      touch ${AWS_WORKSPACE_DIR}/${aws_env}.sh
      echo "export AWS_PROFILE=${aws_env}" > ${AWS_WORKSPACE_DIR}/${aws_env}.sh
    fi
done < ${AWS_DIR}/credentials

_awsworkspace() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  WORDS="$(ls ${AWS_WORKSPACE_DIR} | sed 's/.sh$//g' | grep -v default)"
  echo running
  case "$cur" in
    *)
      COMPREPLY=($(compgen -W "$WORDS" -- "$cur"))
      ;;
  esac
}

function awsworkspace() {
  if [[ ! -z "$@" ]];
  then
      for i in $@; do source ${AWS_WORKSPACE_DIR}/$i.sh; done
  else
    if [[ ! -z "$AWS_PROFILE" ]];
    then
        echo current workspace: $AWS_PROFILE
    else
        echo current workspace: default
    fi
  fi
}

complete -F _awsworkspace awsworkspace
