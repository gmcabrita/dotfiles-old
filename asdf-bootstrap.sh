#!/bin/sh
set -e

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.0
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
asdf plugin-add go https://github.com/kennyp/asdf-golang
asdf install erlang 19.2
asdf install elixir 1.3.4
asdf install go 1.7.4
asdf global erlang 19.2 && asdf global elixir 1.3.4 && asdf global go 1.7.4