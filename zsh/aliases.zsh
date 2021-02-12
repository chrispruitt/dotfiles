# Reload it all
alias reload!='. ~/.zshrc'

# Open dotfiles in VS Code
alias dotfiles='code ~/.dotfiles/'

alias name='scutil --get ComputerName' # get computer name

# Mysql
alias importdb='echo "mysql -u <username> -p <databasename> < <filename.sql>"'
alias restartdb='mysql.server restart'
alias startdb='mysql.server start'
alias stopdb='mysql.server stop'

# Open projects
alias opensandbox="code $HOME/workspace/pruitt/sandbox"
alias openterraform="idea $HOME/workspace/g2lytics/misc/terraform"

#keycloak
alias startkeycloak='docker run -p8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin jboss/keycloak'

# readlink OSX
alias readlink='greadlink'

# move around
alias ...='cd ../..'
alias ..='cd ..'
alias .d='cd ~/.dotfiles'
alias h='history'


alias rf='rm -rf'

# tools
alias tool='cd ~/tools'

# ssm
alias ssm-gov='cd ~/tools/ssm-parameter-store-gov; awsworkspace g2lytics-gov'
alias ssm-pub='cd ~/tools/ssm-parameter-store-pub; awsworkspace g2lytics-pub'
alias ssm-gov-open='ssm-gov; code .'
alias ssm-pub-open='ssm-pub; code .'

# navigation shortcuts
alias ws='cd $HOME/workspace'
alias wg='cd $HOME/workspace/g2lytics'
alias wgm='cd $HOME/workspace/g2lytics/misc'
alias wgo='cd $HOME/go/src'
alias wp='cd $HOME/workspace/pruitt'
alias wt='cd $HOME/workspace/tutorials'
alias makesrc='mkdir -p ~/code/apis ~/code/data ~/code/oss ~/code/services ~/code/syncs ~/code/tmp ~/code/tools'
alias wsp='cd $HOME/workspace/projects'
alias kbn='cd /Volumes/Keybase/private/chrispruitt/notes'
alias kbp='cd /Volumes/Keybase/public/chrispruitt'
alias kb='cd /Volumes/Keybase'

# markdown notes
alias notes='open -a typora /Volumes/Keybase/private/chrispruitt/notes/'

# typora
alias typora="open -a typora"

# MacVim
# alias vim='mvim -v'
# alias v='mvim -v .'

# PS
alias psa="ps aux"
alias psg="ps aux | grep "

# Moving around
alias cdb='cd -'
alias cls='clear;ls'

# Show human friendly numbers and colors
alias df='df -h'
alias du='du -h -d 2'

alias la='ls -a'
alias ll='ls -alGh'
alias ls='ls -Gh'
alias lsg='ll | grep'

# editing
alias ae='vi -v ~/.dotfiles/zsh/aliases.zsh'
alias de='vi -v ~/.dotfiles'
alias bf='vi -v ~/.dotfiles/Brewfile'
alias ge='vi -v ~/.dotfiles/git/aliases.zsh'
alias pe='vi -v ~/.dotfiles/zsh/prompt.zsh'
alias ve='vi -v ~/.vimrc'
alias ze='vi -v ~/.zshrc'
alias .v='vi ~/.vimrc'
alias .z='vi ~/.zshrc'
alias .h='vi /etc/hosts'

# Homebrew
alias brewu='brew update  && brew upgrade --all && brew cleanup && brew prune && brew doctor'

# bitbucket shortcuts
alias pull-requests='python -mwebbrowser https://bitbucket.org/dashboard/pullrequests?section=teams'

# just relax with a joke
alias joke='curl -H "Accept: text/plain" https://icanhazdadjoke.com/ && echo '

# weather
alias weather='curl wttr.in'

# gopass frequents
alias sftp-ga-prod='sshpass -p $(gopass show -f -o g2lytics/client/ga/prod/sftp/rdecardenas) sftp rdecardenas@eft.dor.ga.gov'
alias sftp-ga-test='sshpass -p $(gopass show -f -o g2lytics/client/ga/test/sftp/rdecardenas) sftp rdecardenas@eft-test.dor.ga.gov'
alias cyber-hygiene-assessment-pass='gopass show -c g2lytics/misc/ncats-pdf'

# unset AWS workspace and clear
alias clr='unset AWS_PROFILE; clear'

# remove all terraform init files recursively
alias tf-reset-all='find . -name .terraform -exec rm -rf {} \;'
