# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# open the repos origin in browser
alias openrepo="git config --get remote.origin.url | awk '{ gsub(\":\",\"/\"); print  }' | awk '{ print \"http://\"substr(\$1,5);  }' | xargs open"

# The rest of my fun git aliases
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gc='git commit'
alias gca='git commit -a'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'
alias gut='git update-index --assume-unchanged' # gut config.json will stop tracking config.json

alias gstsh='git stash'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsh='git show'
alias gshw='git show'
alias gshow='git show'
alias gi='vim .gitignore'
alias ga='git add -A'
alias gap='git add -p'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gf='git fetch'
alias gfp='git fetch --prune'
alias gfa='git fetch --all'
alias gfap='git fetch --all --prune'
alias gfch='git fetch'
alias gd='git diff'
alias gsu='git submodule update' # gsu dir-from-gitmodules

# Staged and cached are the same thing
alias gdc='git diff --cached -w'
alias gds='git diff --staged -w'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsh='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gclndfx='git clean -dfx'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gbg='git bisect good'
alias gbb='git bisect bad'
alias gdmb='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias gbv='git branch -v'
alias gcb='git checkout -b'


#
# git-flow cheats
# brew info git-flow-avh
# brew install git-flow-avh
#
# init      Initialize a new git repo with support for the branching model.
# feature   Manage your feature branches.
# bugfix    Manage your bugfix branches.
# release   Manage your release branches.
# hotfix    Manage your hotfix branches.
# support   Manage your support branches.
# version   Shows version information.
# config    Manage your git-flow configuration.
# log       Show log deviating from base branch.

# INIT
# Init a new git repo with branching model support
alias gfinit='git flow init'

## FEATURE
# Start a new feature
alias gffstart='git flow feature start ' # <feature-name>
# Finish up a feature
alias gfffinish='git flow feature finish ' # <feature-name>
# Publish a feature
alias gffpublish='git flow feature publish ' # <feature-name>
# Getting a published feature
alias gffpull='git flow feature pull origin ' # <feature-name>
# Track a feature
alias gfftrack='git flow feature track ' # <feature-name>

## RELEASE
# Start a release
alias gfrstart='git flow release start ' # <release-name> [<sha1-hash-to-start-release-from>]
# Publish a release
alias gfrpublish='git flow release publish ' # <release-name>
# Track a release
alias gfrtrack='git flow release track ' # <release-name>
# Finish a release
alias gfrfinish='git flow release finish ' # <release-name>
# Push tags
alias gfptags='git push --tags'

# HOTFIX
# Start a hotfix
alias gfhstart='git flow hotfix start ' # <version> [<base-name>]'
# Finish a hotfix
alias gfhfinish='git flow hotfix finish ' # <version>
# Publish a hotfix
alias gfhpush='git flow hotfix publish ' # <version>
# Getting a published hotfix
alias gfhpull='git flow hotfix pull origin ' # <hotfix-name>

alias git-rm-all-branches='git branch | grep -v "master" | xargs git branch -D '
