function git-rm-tag() {
  git push -d origin $1
  git tag -d $1
}