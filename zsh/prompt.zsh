autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

#ruby_version() {
#  if (( $+commands[rbenv] ))
#  then
#    echo "$(rbenv version | awk '{print $1}')"
#  fi
#
#  if (( $+commands[rvm-prompt] ))
#  then
#    echo "$(rvm-prompt | awk '{print $1}')"
#  fi
#}
#
#rb_prompt() {
#  if ! [[ -z "$(ruby_version)" ]]
#  then
#    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%}"
#  else
#    echo ""
#  fi
#}

package_version() {
  if [[ -f ./package.json ]]
  then
    echo "%{$fg_bold[yellow]%}v$(jq -r .version package.json)%{$reset_color%}"
  else
    echo ""
  fi
}

node_version() {
  if ! [[ -z $(node -v) ]]
  then
    echo "%{$fg_bold[blue]%}node/%{$reset_color%}%{$fg_bold[yellow]%}$(node -v)%{$reset_color%} "
  else
    echo "missing node"
  fi
}

directory_name() {
  echo "%{$fg_bold[blue]%}%1/%\/%{$reset_color%}"
}

is_python_virtual() {
  if ! [[ -z $(echo $VIRTUAL_ENV) ]]
  then
    echo "%{$fg_bold[cyan]%}(venv)%{$reset_color%}"
  else
    echo "%{$fg_bold[cyan]%}(global)%{$reset_color%}"
  fi
}

python_env() {
  if ! [[ -z $(python3 -V) ]]
  then
    echo "%{$fg_bold[green]%}py/%{$reset_color%}%{$fg_bold[yellow]%}$(python -V)/%{$reset_color%}$(is_python_virtual) "
  else
    echo "missing python"
  fi
}

aws_workspace() {
  if [[ ! -z "$AWS_PROFILE" ]]
  then
    echo "%{$fg_bold[cyan]%}aws_ws/%{$reset_color%}%{$fg_bold[yellow]%}$AWS_PROFILE%{$reset_color%} "
  fi
}

export PROMPT=$'\n$(directory_name) $(python_env)$(package_version) $(aws_workspace) $(git_dirty)$(need_push)\n› '
#export PROMPT=$'\n$(node_version)$(rb_prompt)$(directory_name)$(package_version) $(git_dirty)$(need_push)\n› '

set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
