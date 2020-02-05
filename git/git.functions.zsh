function git-rm-tag() {
  git push -d origin $1
  git tag -d $1
}

function git-retag() {
  git fetch --tags
  git push -d origin $1
  git push origin refs/tags/$1
}