.PHONY: update test

all: linux dotfiles go python nodejs kube

# installs the base linux system
linux:
	sudo ./install.sh linux

# updates the dotfiles
dotfiles:
	./install.sh dotfiles

# installs go
go:
	./install.sh golang

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
