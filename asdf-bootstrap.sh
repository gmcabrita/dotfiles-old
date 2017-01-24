#!/bin/bash
set -e

ERLANG="19.2";
ELIXIR="1.4.0";
GO="1.7.4";

# asdf
read -p "Do you want to install asdf? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.0
	. $HOME/.asdf/asdf.sh

	read -p "Do you want to install Erlang? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
		asdf install erlang $ERLANG
		asdf global erlang $ERLANG
	fi;

	read -p "Do you want to install Elixir? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
		asdf install elixir $ELIXIR
		asdf global elixir $ELIXIR
	fi;

	read -p "Do you want to install Go? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		asdf plugin-add go https://github.com/kennyp/asdf-golang
		asdf install go $GO
		asdf global go $GO
	fi;
fi;