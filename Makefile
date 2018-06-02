.PHONY: update test

all: linux dotfiles go python nodejs kube

# installs the base linux system
linux:
	sudo ./install.sh linux

# sets up fonts
fonts:
	sudo ./install.sh fonts

# updates the dotfiles
dotfiles:
	./install.sh dotfiles || true

# installs elixir
elixir:
	./install.sh elixir

# installs go
go:
	./install.sh golang

# installs rust
rust:
	./install.sh rust

# installs swift
swift:
	./install.sh swift

# installs python
python:
	./install.sh python

# installs nodejs
nodejs:
	./install.sh nodejs

# installs kubernetes related utils
kube:
	./install.sh kube

# tests all scripts using shellcheck
test:
	./test.sh
