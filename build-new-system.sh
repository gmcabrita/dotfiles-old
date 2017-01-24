#!/bin/bash
set -e

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y install \
	ca-certificates \
	apt-transport-https \
	software-properties-common \
	bash-completion \
	shellcheck \
	git \
	build-essential \
	automake \
	autoconf \
	readline-common \
	ncurses-base \
	openssl \
	libyaml-dev \
	libxslt1-dev \
	libxslt1-dev \
	libffi-dev \
	libtool \
	unixodbc \
	unixodbc-dev \
	m4 \
	zlib1g-dev \
	zlibc \
	libncurses5-dev \
	libwxgtk3.0-dev \
	libgl1-mesa-dev \
	libglu1-mesa-dev \
	libpng3 \
	libssh-dev \
	curl \
	htop \
	wget \
	vlc \
	deluge \
	aspell \
	aspell-pt-pt \
	ranger \
	p7zip-full \
	jq \
	tmux \
	vim \
	imagemagick \
	ttf-ubuntu-font-family \
	openjdk-8-jdk \
	openjdk-8-jre \
	ffmpeg \
	tree \
	scrot \
	arandr \
	dos2unix \
	xclip \
	texlive-full \
	pandoc \
	pcregrep \
	linux-image-extra-$(uname -r) \
	linux-image-extra-virtual \
	dconf-tools

# Teleport
touch ~/.tp_aliases
touch ~/.tp_history
sudo cp .completion /etc/bash_completion.d/teleport

# Docker
read -p "Do you want to install Docker? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
	sudo add-apt-repository -y \
		"deb https://apt.dockerproject.org/repo/ \
		ubuntu-$(lsb_release -ucs) \
		main"
	sudo apt-get update
	sudo apt-get -y install docker-engine

	# Setup Docker for non-root
	sudo groupadd docker
	sudo usermod -aG docker "$USER"
fi;

# Neovim
read -p "Do you want to install Neovim? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo add-apt-repository -y ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get -y install neovim
fi;

# Dropbox
read -p "Do you want to install Dropbox? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -o dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb
	sudo dpkg -i dropbox.deb
	sudo apt-get -f -y install
fi;

# Keybase
read -p "Do you want to install Keybase? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -o keybase.deb https://prerelease.keybase.io/keybase_amd64.deb
	sudo dpkg -i keybase.deb
	sudo apt-get -f -y install
	echo "Don't forget to execute `run_keybase` later to setup Keybase."
fi;

# Chrome
read -p "Do you want to install Chrome? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -o chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i chrome.deb
	sudo apt-get -f -y install
fi;

# Enpass
read -p "Do you want to install Enpass? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -fsSL https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -
	sudo add-apt-repository -y \
		"deb http://repo.sinew.in/ \
		stable \
		main"
	sudo apt-get update
	sudo apt-get -y install enpass
fi;

# Discord
read -p "Do you want to install Discord? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -o discord.deb https://discordapp.com/api/download?platform=linux&format=deb
	sudo dpkg -i discord.deb
	sudo apt-get -f -y install
fi;

# Sublime Text 3
read -p "Do you want to install Sublime Text 3? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -o sublime-text.deb https://download.sublimetext.com/sublime-text_build-3125_amd64.deb
	sudo dpkg -i sublime-text.deb
	sudo apt-get -f -y install
fi;

# Yarn
read -p "Do you want to install Yarn? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	sudo add-apt-repository -y \
			"deb https://dl.yarnpkg.com/debian/ \
			stable \
			main"
	sudo apt-get update
	sudo apt-get -y install yarn

	# Install dockerlint
	sudo yarn global add dockerlint
fi;

# Skype
read -p "Do you want to install Skype? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -o skype.deb https://www.skype.com/en/download-skype/skype-for-linux/downloading/?type=ubuntu64
	sudo dpkg -i skype.deb
	sudo apt-get -f -y install
fi;