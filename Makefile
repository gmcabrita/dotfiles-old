.PHONY: update test

all: base dotfiles go python elixir rust nodejs kube

# installs the base system
base:
	sudo ./install.sh base

# pulls the latest changes and updates the dotfiles
dotfiles:
	./install.sh dotfiles

# go
go:
	./install.sh golang

# rust
rust:
	./install.sh rust

# python
python:
	./install.sh python

# nodejs
nodejs:
	./install.sh nodejs

# kube
kube:
	./install.sh kube

# tests all scripts using shellcheck
test:
	./test.sh
