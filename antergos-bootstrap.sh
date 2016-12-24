#!/bin/sh
set -e

# update
sudo pacman --noconfirm -Syu

# install a bunch of stuff
sudo pacman --noconfirm -S ca-certificates zsh shellcheck git clang base-devel automake autoconf readline ncurses openssl libyaml stow libxslt libffi libtool unixodbc m4 glibc gcc-libs zlib wxgtk nvidia nvidia-libgl lib32-nvidia-libgl glu libpng libssh curl wget vlc deluge libdvdcss aspell neovim ranger htop p7zip jq tmux imagemagick ttf-hack ttf-google-fonts jdk8-openjdk jre8-openjdk jre8-openjdk-headless ffmpeg tree scrot arandr dropbox dos2unix numix-icon-theme xclip python2-neovim python-neovim texlive-most pandoc steam obs-studio docker keybase gconf gconf-editor dconf dconf-editor

# setup docker for non-root
sudo groupadd docker
sudo usermod -aG docker "$USER"

# install a bunch of extra stuff from AUR
yaourt --noconfirm -S z google-chrome libtinfo pgcli ngrok heroku-toolbelt slack-desktop enpass-bin discord-canary sublime-text-dev gtk-theme-arc-git yarn simplenote-electron-bin chrome-gnome-shell-git skypeforlinux-bin

sudo yarn global add dockerlint
