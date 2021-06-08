# enable terraform autocomplete for zsh
# complete -o nospace -C /usr/local/bin/terraform terraform

# alias execute terraform.sh wrapper in current directory
alias t="./terraform.sh"

_t() {
    local cur prev

    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case ${COMP_CWORD} in
        1)
            WORDS="$(ls $(pwd)/workspaces)"
            COMPREPLY=($(compgen -W "$WORDS" -- "${cur}"))
            ;;
        2)
            WORDS="$(ls $(pwd)/workspaces/${prev})"
            COMPREPLY=($(compgen -W "$WORDS" -- "${cur}"))
            ;;
    esac
}

complete -F _t t
