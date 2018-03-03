#!/bin/bash
set -e
set -o pipefail

# chooses a user account to use for the installation
get_user() {
    if [ -z "${TARGET_USER-}" ]; then
        PS3='Which user account should be used? '
        mapfile -t options < <(find /home/* -maxdepth 0 -printf "%f\\n" -type d)
        select opt in "${options:?[@]}"; do
            readonly TARGET_USER=$opt
            break
        done
    fi
}

# checks if we are running as root
check_is_sudo() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run as root."
        exit
    fi
}

# checks if we are running without
check_isnt_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "Please run without root."
        exit
    fi
}

# sets up the base third-party software sources
setup_sources_base() {
    apt update
    apt -y upgrade
    apt install -y \
        curl \
        wget \
        apt-transport-https \
        ca-certificates

    dist=$(lsb_release -cs)
    os=$(lsb_release -is | awk '{ print tolower($1) }')

    # google cloud sdk
    echo "deb http://packages.cloud.google.com/apt cloud-sdk-${dist} main"  > /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

    # docker
    curl -fsSL https://download.docker.com/linux/"${os}"/gpg | apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/${os} ${dist} edge" > /etc/apt/sources.list.d/docker.list

    # pony-lang
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "D401AB61"
    echo "deb https://dl.bintray.com/pony-language/ponyc-debian pony-language main" > /etc/apt/sources.list.d/pony-lang.list

    # bcc-tools
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D4284CDD
    echo "deb https://repo.iovisor.org/apt/${dist} ${dist} main" > /etc/apt/sources.list.d/bcc.list

    # yubico
    add-apt-repository ppa:yubico/stable
}

# sets up third-party software sources
setup_sources() {
    setup_sources_base;

    # chrome
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

    # dropbox
    apt-key adv --keyserver pgp.mit.edu --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
    echo "deb http://linux.dropbox.com/${os} xenial main" > /etc/apt/sources.list.d/dropbox.list

    # slack
    curl -fsSL https://packagecloud.io/slacktechnologies/slack/gpgkey | apt-key add -
    echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" > /etc/apt/sources.list.d/slack.list
    echo "deb-src https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" >> /etc/apt/sources.list.d/slack.list

    # spotify
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
    echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list

    # enpass
    curl -fsSL https://dl.sinew.in/keys/enpass-linux.key | apt-key add -
    echo "deb http://repo.sinew.in/ stable main" > /etc/apt/sources.list.d/enpass.list

    # zeal
    add-apt-repository -y ppa:zeal-developers/ppa

    # keybase
    curl -fsSL https://keybase.io/docs/server_security/code_signing_key.asc | apt-key add -
    echo "deb http://prerelease.keybase.io/deb stable main" > /etc/apt/sources.list.d/keybase.list


    # vscode
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
}

# installs the vanilla gnome desktop and a nice shell and icon theme
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

# installs the base packages
base() {
    apt update
    apt -y install \
        software-properties-common \
        wrk \
        graphviz \
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
        libncurses5-dev \
        libwxgtk3.0-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        libpng-dev \
        git-extras \
        python3 \
        python3-pip \
        libssh-dev \
        htop \
        aspell \
        aspell-pt-pt \
        p7zip-full \
        jq \
        tmux \
        imagemagick \
        openjdk-8-jdk \
        openjdk-8-jre \
        ffmpeg \
        tree \
        dos2unix \
        pcregrep \
        linux-image-extra-virtual \
        libssl-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        llvm \
        libncursesw5-dev \
        ponyc \
        xz-utils \
        tk-dev \
        git \
        git-lfs \
        inotify-tools \
        docker-ce \
        google-cloud-sdk \
        build-essential \
        dstat \
        automake \
        autoconf \
        vim \
        exuberant-ctags \
        libopenblas-base \
        libopenblas-dev \
        gdb \
        rlwrap \
        bcc-tools \
        libu2f-host-dev \
        gnupg2 \
        pcscd \
        scdaemon \
        libbcc-examples \
        gnuplot \
        valgrind \
        heaptrack \
        massif-visualizer \
        "linux-headers-$(uname -r)"

    # micro editor
    snap install micro --classic

    # protobuf compiler
    snap install protobuf --classic

    # asciinema
    snap install asciinema --classic

    # setup docker for non-root
    usermod -aG docker "$TARGET_USER"

    # tp files
    touch "/home/$TARGET_USER/.tp_aliases"
    touch "/home/$TARGET_USER/.tp_history"
    chown "$TARGET_USER:$TARGET_USER" "/home/$TARGET_USER/.tp_aliases" "/home/$TARGET_USER/.tp_history"
}

# installs all the packages
full() {
    base;

    apt update
    apt -y install \
        linux-image-extra-"$(uname -r)" \
        vlc \
        alsa-tools-gui \
        fonts-hack-ttf \
        scrot \
        ttf-ubuntu-font-family \
        arandr \
        xclip \
        texlive-full \
        pandoc \
        libvirt-bin \
        qemu-kvm \
        zeal \
        enpass \
        code \
        spotify-client \
        google-chrome-stable \
        dropbox \
        slack-desktop \
        postgresql \
        ubuntu-restricted-extras \
        keybase \
        hollywood \
        wallstreet \
        yubikey-piv-manager

    # install discord
    curl -so discord.deb https://dl.discordapp.net/apps/linux/0.0.4/discord-0.0.4.deb
    apt install -y ./discord.deb
    rm ./discord.deb

    # setup kvm for non-root
    usermod -aG libvirt "$TARGET_USER"

    # set docker to autostart
    systemctl enable docker

    # set vscode as default editor
    update-alternatives --set editor /usr/bin/code

    if [ -d "/sys/class/power_supply" ]; then
        apt -y install tlp
        tlp start
    fi

}

# installs some extra fonts
install_fonts() {
    cd "$(dirname "${BASH_SOURCE[0]}")"
    cp -r .fonts/* /usr/share/fonts
}

# fixes spotify so it can play local files
fix_spotify() {
    wget -N https://github.com/ramedeiros/spotify_libraries/raw/master/libavcodec.so.54.71.100 -O /usr/lib/x86_64-linux-gnu/libavcodec.so.54
    wget -N https://github.com/ramedeiros/spotify_libraries/raw/master/libavformat.so.54.36.100 -O /usr/lib/x86_64-linux-gnu/libavformat.so.54
    wget -N https://github.com/ramedeiros/spotify_libraries/raw/master/libavutil.so.52.6.100 -O /usr/lib/x86_64-linux-gnu/libavutil.so.52
    ldconfig
}

# checks if asdf is installed and installs it
check_asdf_and_install() {
    if [ ! -d "$HOME/.asdf" ]; then
        install_asdf
    fi
}

# checks if pyenv is installed and installs it
check_pyenv_and_install() {
    if [ ! -d "$HOME/.pyenv" ]; then
        install_pyenv
    fi
}

# checks if rustup is installed and installs it
check_rustup_and_install() {
    if [ ! -d "$HOME/.rustup" ]; then
        install_rustup
    fi
}

# installs asdf
install_asdf() {
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.0
    # shellcheck disable=SC1090
    . ~/.asdf/asdf.sh || true
    asdf update
}

# installs pyenv
install_pyenv() {
    curl -fsSL https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
    # shellcheck disable=SC1090
    . ~/.bash_profile || true
}

# installs rustup
install_rustup() {
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
    # shellcheck disable=SC1090
    . ~/.bash_profile || true
    rustup install nightly
    rustup component add rls-preview rustfmt-preview rust-analysis rust-src
    rustup component add --toolchain nightly rls-preview rustfmt-preview rust-analysis rust-src
}

# installs go and some go packages
install_golang() {
    golangv=$(curl -sSL "https://golang.org/VERSION?m=text" | sed 's/go//')
    asdf plugin-add go https://github.com/kennyp/asdf-golang || true
    asdf install go "$golangv" || true
    asdf global go "$golangv"

    go get -u -v github.com/magefile/mage \
        github.com/google/codesearch/cmd/... \
        github.com/goreleaser/goreleaser \
        github.com/dvyukov/go-fuzz/go-fuzz \
        github.com/dvyukov/go-fuzz/go-fuzz-build \
        github.com/nsf/gocode \
        github.com/fatih/gomodifytags \
        github.com/lukehoban/go-outline \
        github.com/newhook/go-symbols \
        golang.org/x/tools/cmd/guru \
        golang.org/x/tools/cmd/gorename \
        github.com/rogpeppe/godef \
        sourcegraph.com/sqs/goreturns \
        github.com/alecthomas/gometalinter \
        github.com/sourcegraph/go-langserver \
        github.com/golang/lint/golint \
        golang.org/x/tools/cmd/cover \
        golang.org/x/tools/cmd/goimports \
        github.com/derekparker/delve/cmd/dlv \
        github.com/uber/go-torch \
        github.com/tsliwowicz/go-wrk \
        github.com/tockins/realize \
        github.com/uber-common/cpustat \
        github.com/google/gops \
        github.com/rakyll/hey \
        github.com/peterbourgon/stats \
        github.com/golang/dep/cmd/dep \
        github.com/google/pprof \
        github.com/kintoandar/fwd \
        github.com/apex/static/cmd/static-docs \
        github.com/ktr0731/evans \
        github.com/golang/protobuf/proto \
        github.com/golang/protobuf/protoc-gen-go \
        github.com/ckaznocha/protoc-gen-lint \
        google.golang.org/grpc \
        github.com/ajstarks/svgo/benchviz \
        github.com/uudashr/gopkgs/cmd/gopkgs

    gometalinter --install
}

# installs python and some python packages
install_python() {
    pythonv=$(pyenv install --list | grep -v "[a-Z]" | tail -1 | sed -e "s/  //")
    pyenv install -s "$pythonv"
    pyenv global "$pythonv"

    pip install -U \
        pipenv \
        docker-compose \
        ipython \
        mypy \
        requests \
        hypothesis \
        flask \
        django \
        sqlalchemy \
        pylint \
        autopep8 \
        pytest \
        nose \
        pycodestyle \
        prospector \
        flake8 \
        pylama \
        pydocstyle \
        awscli \
        aws-shell \
        matplotlib \
        pandas \
        httpie \
        tablib \
        maya \
        records \
        pgcli \
        python-language-server \
        pyls-mypy \
        isort \
        pyls-isort
}

# updates rustup and rust, also installs some rust packages
install_rust() {
    rustup self update
    rustup update
    cargo install --force \
        racer \
        rustsym \
        cargo-check \
        cargo-watch \
        cargo-release \
        ripgrep \
        cargo-fuzz \
        afl

    rustup run nightly cargo install clippy --force
}

# installs elixir and erlang
install_elixir() {
    erlangv=$(curl -s https://api.github.com/repos/erlang/otp/releases/latest | jq -r ".tag_name" | sed -e "s/OTP-//")
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang || true
    asdf install erlang "$erlangv" || true
    asdf global erlang "$erlangv"

    elixirv=$(curl -s https://api.github.com/repos/elixir-lang/elixir/releases/latest | jq -r ".tag_name" | sed -e "s/v//")
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir || true
    asdf install elixir "$elixirv" || true
    asdf global elixir "$elixirv"

    yes | mix local.hex
    yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
    mix local.rebar --force
}

# installs nodejs and some nodejs packages
install_nodejs() {
    nodejsv=$(curl -s https://api.github.com/repos/nodejs/node/releases/latest | jq -r ".tag_name" | sed -e "s/v//")
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
    asdf install nodejs "$nodejsv" || true
    asdf global nodejs "$nodejsv"
    npm -g install dockerlint javascript-typescript-langserver diff2html-cli
}

# installs terraform and some kubernetes utilities
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

# updates the local dotfiles with the ones in the repository
get_dotfiles() {
    cd "$(dirname "${BASH_SOURCE[0]}")"

    rsync --exclude ".git/" \
        --exclude ".fonts/" \
        --exclude ".local/" \
        --exclude "install.sh" \
        --exclude "README.md" \
        --exclude ".travis.yml" \
        --exclude "test.sh" \
        --exclude ".dconf" \
        --exclude "Makefile" \
        -avh --no-perms . ~

    # dconf load /org/gnome/ < .dconf

    # shellcheck disable=SC1090
    . ~/.bash_profile
}

usage() {
    echo -e "install.sh\\n"
    echo "Usage:"
    echo "  linux                               - setup sources & install base pkgs"
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

    if [[ $cmd == "linux" ]]; then
        check_is_sudo
        get_user
        setup_sources
        full
        # install_gnome
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
