#!/bin/bash

LIB_DIR="$HOME/lib"

prep() {
  [[ -d "$LIB_DIR" ]] || mkdir "$LIB_DIR"
}

cloneRepo() {
  rm -rf "$LIB_DIR/git-setup" >/dev/null 2>&1 # Careful with this command
  git clone "git@github.com:sumanmukherjee03/git-setup.git" "$LIB_DIR/git-setup"
}

build() {
  local file
  pushd . &> /dev/null
  cd "$LIB_DIR/git-setup"
  for file in config/*; do
    cp "$file" "$HOME/.${file##*/}"
  done
  popd
}

main() {
  local name="$1"
  local email="$2"

  prep
  cloneRepo
  build

  sed -i.bak -e "s#<name>#$name#g;s#<email>#$email#g;s#<editor>#$EDITOR#g" "$HOME/.gitconfig"
  rm "$HOME/.gitignore.bak"
}

main "$@"
