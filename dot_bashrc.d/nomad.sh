function nomad-exec() {
  TASK_NAME=$1
  CMD=$2

  FIRST_RUNNING_ALLOC=$(nomad job allocs -json $TASK_NAME | jq -r 'nth(0; .[] | select(.ClientStatus=="running")) | .ID')
  echo "Running commad \"$CMD\" in $FIRST_RUNNING_ALLOC"
  nomad alloc exec $FIRST_RUNNING_ALLOC $CMD
}


# TODO fix this...
function _nomad-exec() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  WORDS="$(nomad job status | awk '{if (NR!=1) {print $1}}' | xargs)"
  case "$cur" in
    *)
      COMPREPLY=($(compgen -W "$WORDS" -- "$cur"))
      ;;
  esac
}

complete -F _nomad-exec nomad-exec
