_awssso() {
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    WORDS="$(cat ~/.aws/credentials | grep "^\[" | sed 's/\[//;s/\]//')"
    case "$cur" in
        *)
        COMPREPLY=($(compgen -W "$WORDS" -- "$cur"))
        ;;
    esac
}

awssso () {
    export AWS_PROFILE=${1} 
    export AWS_REGION=$(cat ~/.aws/credentials | grep -A20 "$AWS_PROFILE" | grep sso_region | awk '{print $3}' | head -1)
    export AWS_ACCOUNT=$(cat ~/.aws/credentials | grep -A20 "$AWS_PROFILE" | grep sso_account_id | awk '{print $3}' | head -1)
    aws sso login --profile $AWS_PROFILE
}

complete -F _awssso awssso


aws-get-sso-profiles() {
    PROFILES=("${(@f)$(cat ~/.aws/credentials | grep "^\[" | sed 's/\[//;s/\]//')}")
    WORDS=()
    for p in ${PROFILES}; do
        if [[ $(cat ~/.aws/credentials | grep -A8 ${p} | grep sso_start_url | head -1) ]]; then
            WORDS+=${p}
        fi
    done

    echo ${WORDS}
}