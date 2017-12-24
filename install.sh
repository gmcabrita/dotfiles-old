#!/bin/bash
set -e
set -o pipefail

# Choose a user account to use for this installation
get_user() {
    if [ -z "${TARGET_USER-}" ]; then
        PS3='Which user account should be used? '
        mapfile -t options < <(find /home/* -maxdepth 0 -printf "%f\\n" -type d)
        select opt in "${options[@]}"; do
            readonly TARGET_USER=$opt
            break
        done
    fi
}

check_is_sudo() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run as root."
        exit
    fi
}

check_isnt_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "Please run without root."
        exit
    fi
}

setup_sources() {
    apt update
    apt -y upgrade
    apt install -y \
        curl \
        wget \
        apt-transport-https \
        ca-certificates

    dist=$(lsb_release -cs)
    os=$(lsb_release -is | awk '{ print tolower($1) }')

    # chrome
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

    # dropbox
    apt-key adv --keyserver pgp.mit.edu --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
    echo "deb http://linux.dropbox.com/${os} ${dist} main" > /etc/apt/sources.list.d/dropbox.list

    # slack
    curl -fsSL https://packagecloud.io/slacktechnologies/slack/gpgkey | apt-key add -
    echo "deb https://packagecloud.io/slacktechnologies/slack/${os}/ ${dist} main" > /etc/apt/sources.list.d/slack.list

    # spotify
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
    echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list

    # enpass
    curl -fsSL https://dl.sinew.in/keys/enpass-linux.key | apt-key add -
    echo "deb http://repo.sinew.in/ stable main" > /etc/apt/sources.list.d/enpass.list

    # docker
    curl -fsSL https://download.docker.com/linux/"${os}"/gpg | apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/${os} ${dist} edge" > /etc/apt/sources.list.d/docker.list

    # zeal
    add-apt-repository -y ppa:zeal-developers/ppa

    # sublime-text 3
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list

    # pony-lang
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "D401AB61"
    echo "deb https://dl.bintray.com/pony-language/ponyc-debian pony-language main" > /etc/apt/sources.list.d/pony-lang.list
}

install_gnome() {
    apt update
    apt install -y \
        vanilla-gnome-desktop \
        dconf-tools \
        gnome-tweak-tool \
        arc-theme \
        elementary-icon-theme \
        gnome-shell-extensions \
        chrome-gnome-shell
}

base() {
    apt update
    apt -y install \
        software-properties-common \
        bash-completion \
        shellcheck \
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
        google-chrome-stable \
        dropbox \
        slack-desktop \
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
        linux-image-extra-virtual \
        fonts-hack-ttf \
        libssl-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        llvm \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        git \
        build-essential \
        automake \
        autoconf \
        vim \
        linux-image-extra-"$(uname -r)" \
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

    # install discord
    curl -so discord.deb https://dl.discordapp.net/apps/linux/0.0.3/discord-0.0.3.deb
    apt install -y ./discord.deb
    rm ./discord.deb

    # setup kvm for non-root
    usermod -aG libvirt "$TARGET_USER"
    newgrp libvirt

    # setup docker for non-root
    usermod -aG docker "$TARGET_USER"
    newgrp docker

    # set docker to autostart
    systemctl enable docker

    # install and setup powertop if we are a laptop
    if [ -d "/sys/class/power_supply" ]; then
        apt -y install powertop
        cp systemd/powertop.service /etc/systemd/system/powertop.service
        systemctl daemon-reload
        systemctl enable powertop.service
    fi

    # init teleport
    touch /home/"$TARGET_USER"/.tp_aliases
    touch /home/"$TARGET_USER"/.tp_history
}

install_fonts() {
    # install some extra fonts
    cp -r .fonts/* /usr/share/fonts
}

fix_spotify() {
    # fix spotify local file playback
    wget -N https://github.com/ramedeiros/spotify_libraries/raw/master/libavcodec.so.54.71.100 -O /usr/lib/x86_64-linux-gnu/libavcodec.so.54
    wget -N https://github.com/ramedeiros/spotify_libraries/raw/master/libavformat.so.54.36.100 -O /usr/lib/x86_64-linux-gnu/libavformat.so.54
    wget -N https://github.com/ramedeiros/spotify_libraries/raw/master/libavutil.so.52.6.100 -O /usr/lib/x86_64-linux-gnu/libavutil.so.52
    ldconfig
}

check_asdf_and_install() {
    if [ ! -d "$HOME/.asdf" ]; then
        install_asdf
    fi
}

check_pyenv_and_install() {
    if [ ! -d "$HOME/.pyenv" ]; then
        install_pyenv
    fi
}

check_rustup_and_install() {
    if [ ! -d "$HOME/.rustup" ]; then
        install_rustup
    fi
}

install_asdf() {
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.0
    # shellcheck source=/dev/null
    . ~/.asdf/asdf.sh || true
    asdf update
}

install_pyenv() {
    curl -fsSL https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
    # shellcheck source=/dev/null
    . ~/.bash_profile || true
}

install_rustup() {
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
    # shellcheck source=/dev/null
    . ~/.bash_profile || true
    rustup install nightly
    rustup component add rls-preview || true
    rustup component add rustfmt-preview || true
    rustup component add rust-analysis
    rustup component add rust-src
}

install_golang() {
    golangv=$(curl -sSL "https://golang.org/VERSION?m=text" | sed 's/go//')
    asdf plugin-add go https://github.com/kennyp/asdf-golang || true
    asdf install go "$golangv" || true
    asdf global go "$golangv"

    go get -u github.com/magefile/mage
    go get -u github.com/google/codesearch/cmd/...
    go get -u github.com/mitchellh/gox
    go get -u github.com/dvyukov/go-fuzz/go-fuzz
    go get -u github.com/dvyukov/go-fuzz/go-fuzz-build
    go get -u github.com/nsf/gocode
    go get -u github.com/tpng/gopkgs
    go get -u github.com/fatih/gomodifytags
    go get -u github.com/lukehoban/go-outline
    go get -u github.com/newhook/go-symbols
    go get -u golang.org/x/tools/cmd/guru
    go get -u golang.org/x/tools/cmd/gorename
    go get -u github.com/rogpeppe/godef
    go get -u sourcegraph.com/sqs/goreturns
    go get -u github.com/alecthomas/gometalinter
    go get -u github.com/sourcegraph/go-langserver
    go get -u github.com/golang/lint/golint
    go get -u golang.org/x/tools/cmd/cover
    go get -u golang.org/x/tools/cmd/goimports
    go get -u github.com/derekparker/delve/cmd/dlv
    go get -u github.com/uber/go-torch
    go get -u github.com/tsliwowicz/go-wrk
    go get -u github.com/tockins/realize
    go get -u github.com/uber-common/cpustat
    go get -u github.com/google/gops
    go get -u github.com/rakyll/hey
    go get -u github.com/peterbourgon/stats
    go get -u github.com/golang/dep/cmd/dep

    gometalinter --install
}

install_python() {
    pythonv=$(pyenv install --list | grep -v "[a-Z]" | tail -1 | sed -e "s/  //")
    pyenv install -s "$pythonv"
    pyenv global "$pythonv"

    pip install -U pipenv \
        ipython \
        mypy \
        requests \
        hypothesis \
        flask \
        django \
        sqlalchemy \
        pylint \
        autopep8 \
        yapf \
        pytest \
        nose \
        pycodestyle \
        prospector \
        flake8 \
        pylama \
        pydocstyle \
        awscli \
        aws-shell \
        azure-cli \
        numpy \
        scipy \
        sympy \
        matplotlib \
        pandas \
        scikit-learn \
        theano \
        nltk \
        statsmodels \
        gensim \
        jupyter \
        httpie \
        howdoi \
        tablib \
        maya \
        records \
        pgcli \
        python-language-server \
        pyls-mypy \
        isort \
        pyls-isort
}

install_rust() {
    cargo install racer --force
    cargo install rustsym --force
    cargo install cargo-check --force
    cargo install cargo-release --force
    cargo install ripgrep --force
    cargo install cargo-fuzz --force
    rustup run nightly cargo install clippy --force
}

install_elixir() {
    erlangv=$(curl -s https://api.github.com/repos/erlang/otp/releases/latest | jq -r ".tag_name" | sed -e "s/OTP-//")
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang || true
    asdf install erlang "$erlangv" || true
    asdf global erlang "$erlangv"

    elixirv=$(curl -s https://api.github.com/repos/elixir-lang/elixir/releases/latest | jq -r ".tag_name" | sed -e "s/v//")
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir || true
    asdf install elixir "$elixirv" || true
    asdf global elixir "$elixirv"
}

install_nodejs() {
    nodejsv=$(curl -s https://api.github.com/repos/nodejs/node/releases/latest | jq -r ".tag_name" | sed -e "s/v//")
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
    asdf install nodejs "$nodejsv" || true
    asdf global nodejs "$nodejsv"
    npm -g install dockerlint javascript-typescript-langserver
}

install_kube() {
    terraformv=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r ".tag_name" | sed -e "s/v//")
    asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git || true
    asdf install terraform "$terraformv" || true
    asdf global terraform "$terraformv"

    minikubev=$(curl -s https://storage.googleapis.com/minikube/releases.json | jq -r ".[0].name" | sed -e "s/v//")
    asdf plugin-add minikube https://github.com/alvarobp/asdf-minikube.git || true
    asdf install minikube "$minikubev" || true
    asdf global minikube "$minikubev"

    kubectlv=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt | sed -e "s/v//")
    asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git || true
    asdf install kubectl "$kubectlv" || true
    asdf global kubectl "$kubectlv"

    kubecfgv=$(curl -s https://api.github.com/repos/ksonnet/kubecfg/releases/latest | jq -r ".tag_name" | sed -e "s/v//")
    asdf plugin-add kubecfg https://github.com/Banno/asdf-ksonnet.git || true
    asdf install kubecfg "$kubecfgv" || true
    asdf global kubecfg "$kubecfgv"
}

get_dotfiles() {
    cd "$(dirname "${BASH_SOURCE[0]}")"
    git pull origin master

    rsync --exclude ".git/" \
        --exclude "systemd/" \
        --exclude ".fonts/" \
        --exclude "asdf-bootstrap.sh" \
        --exclude "rustup-bootstrap.sh" \
        --exclude "golang-bootstrap.sh" \
        --exclude "python-bootstrap.sh" \
        --exclude "install.sh" \
        --exclude "st3-fetch.sh" \
        --exclude "README.md" \
        --exclude ".travis.yml" \
        --exclude "test.sh" \
        --exclude "Makefile" \
        -avh --no-perms . ~

    # shellcheck source=/dev/null
    . ~/.bash_profile
}

usage() {
    echo -e "install.sh\\n"
    echo "Usage:"
    echo "  base                                - setup sources & install base pkgs"
    echo "  dotfiles                            - get dotfiles"
    echo "  asdf                                - install asdf and plugins"
    echo "  golang                              - install golang and packages"
    echo "  python                              - install python and packages"
    echo "  rust                                - install rust and packages"
    echo "  elixir                              - install erlang and elixir"
    echo "  nodejs                              - install nodejs"
    echo "  kube                                - install minikube, kubectl, etc"
}

main() {
    local cmd=$1

    if [[ -z "$cmd" ]]; then
        usage
        exit 1
    fi

    if [[ $cmd == "base" ]]; then
        check_is_sudo
        get_user
        setup_sources
        base
        install_gnome
        install_fonts
        fix_spotify
    elif [[ $cmd == "dotfiles" ]]; then
        check_isnt_sudo
        get_dotfiles
    elif [[ $cmd == "asdf" ]]; then
        check_isnt_sudo
        check_asdf_and_install
    elif [[ $cmd == "golang" ]]; then
        check_isnt_sudo
        check_asdf_and_install
        install_golang
    elif [[ $cmd == "python" ]]; then
        check_isnt_sudo
        check_pyenv_and_install
        install_python
    elif [[ $cmd == "rust" ]]; then
        check_isnt_sudo
        check_rustup_and_install
        install_rust
    elif [[ $cmd == "elixir" ]]; then
        check_isnt_sudo
        check_asdf_and_install
        install_elixir
    elif [[ $cmd == "nodejs" ]]; then
        check_isnt_sudo
        check_asdf_and_install
        install_nodejs
    elif [[ $cmd == "kube" ]]; then
        check_isnt_sudo
        check_asdf_and_install
        install_kube
    else
        usage
    fi
}

main "$@"
