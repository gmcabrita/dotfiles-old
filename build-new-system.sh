#!/bin/bash
set -e

#### Update and upgrade the base system

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install curl wget

#### Setup 3rd party apt-repos

# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Enpass
curl -fsSL https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -
sudo add-apt-repository -y \
    "deb http://repo.sinew.in/ \
    stable \
    main"

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    edge"

# Zeal
sudo add-apt-repository -y ppa:zeal-developers/ppa

# Sublime Text 3
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Pony
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "D401AB61"
echo "deb https://dl.bintray.com/pony-language/ponyc-debian pony-language main" | sudo tee -a /etc/apt/sources.list

#### Update and install final packages

sudo apt-get update
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
    libpng-dev \
    python3 \
    python3-pip \
    libssh-dev \
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
    linux-image-extra-"$(uname -r)" \
    linux-image-extra-virtual \
    dconf-tools \
    fonts-hack-ttf \
    libssl-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    exuberant-ctags \
    libopenblas-base \
    libopenblas-dev \
    gdb \
    libvirt-bin \
    qemu-kvm \
    dstat \
    zeal \
    docker-ce \
    enpass \
    sublime-text \
    spotify-client \
    ponyc \
    ubuntu-restricted-extras

#### Install .deb

# Dropbox
curl -Lso dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb
sudo apt-get install -y ./dropbox.deb

# Chrome
curl -so chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ./chrome.deb

# Discord
curl -so discord.deb https://dl.discordapp.net/apps/linux/0.0.3/discord-0.0.3.deb
sudo apt-get install -y ./discord.deb

# Slack
curl -so slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.0-amd64.deb
sudo apt-get install -y ./slack.deb

#### Setup misc stuff

# Teleport
touch ~/.tp_aliases
touch ~/.tp_history

# Setup KVM for non-root
sudo usermod -aG libvirt "$USER"
newgrp libvirt

# Setup Docker for non-root
sudo usermod -aG docker "$USER"
newgrp docker

# Set Docker to autostart
sudo systemctl enable docker

# Setup PowerTOP in case it's a laptop
if [ -d "/sys/class/power_supply" ]; then
    sudo apt-get -y install powertop;
    sudo cp systemd/powertop.service /etc/systemd/system/powertop.service
    sudo systemctl daemon-reload
    sudo systemctl enable powertop.service
fi;

#### Cleanup

rm ./*.deb

#### Grab dotfiles

./update-dotfiles.sh

#### Fonts

sudo cp -r .fonts/* /usr/share/fonts

#### Run remaining bootstraps

./asdf-bootstrap.sh
./python-bootstrap.sh
./golang-bootstrap.sh
./rustup-bootstrap.sh
