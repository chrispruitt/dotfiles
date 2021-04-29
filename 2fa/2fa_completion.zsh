# copy to clipboard on lookup
alias 2fc="2fa -clip"

_2fa() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  WORDS="$(2fa | awk '{print $2;}' )"
  case "$cur" in
    *)
      COMPREPLY=($(compgen -W "$WORDS" -- "$cur"))
      ;;
  esac
}

complete -F _2fa 2fa
complete -F _2fa 2fc
