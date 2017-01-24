#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude "asdf-bootstrap.sh" \
		--exclude "rustup-bootstrap.sh" \
		--exclude "build-new-system.sh" \
		--exclude "update-dotfiles.sh" \
		--exclude "README.md" \
		--exclude ".completion" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;