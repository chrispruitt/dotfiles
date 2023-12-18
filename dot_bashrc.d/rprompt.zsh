aws_prompt_info() {
  if [[ ! -z "$AWS_ACCESS_KEY_ID" ]]
  then
    INFO="%{$fg_bold[cyan]%}ACCESS_KEY:%{$reset_color%}%{$fg_bold[green]%}$AWS_ACCESS_KEY_ID%{$reset_color%}"
  else
    if [[ ! -z "$AWS_PROFILE" ]]
    then
      if [[ ! -z "$AWS_ORG" ]]
      then
        INFO="%{$fg_bold[cyan]%}${AWS_ORG}:%{$reset_color%}%{$fg_bold[green]%}$AWS_PROFILE%{$reset_color%}"
      else
        INFO="%{$fg_bold[cyan]%}default:%{$reset_color%}%{$fg_bold[green]%}$AWS_PROFILE%{$reset_color%}"
      fi
    fi
  fi
  [[ -n "$INFO" ]] || return
  echo "${ZSH_THEME_AWS_PREFIX=<}${INFO}${ZSH_THEME_AWS_SUFFIX=>}"
}

if [[ "$SHOW_AWS_PROMPT" != false && "$RPROMPT" != *'$(aws_prompt_info)'* ]]; then
  RPROMPT='$(aws_prompt_info)'"$RPROMPT"
fi
