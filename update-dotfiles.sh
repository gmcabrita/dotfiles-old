#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE[@]}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude "systemd/" \
		--exclude "asdf-bootstrap.sh" \
		--exclude "rustup-bootstrap.sh" \
		--exclude "golang-bootstrap.sh" \
		--exclude "build-new-system.sh" \
		--exclude "update-dotfiles.sh" \
		--exclude "README.md" \
		--exclude ".travis.yml" \
		--exclude "test.sh" \
		--exclude "Makefile" \
		-avh --no-perms . ~;
  # shellcheck disable=SC1090
	source ~/.bash_profile;
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	doIt;
else
	read -rp "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
