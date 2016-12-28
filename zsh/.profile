# path
export GOPATH=~/Projects/go
export PATH=/usr/local/bin:/usr/local/sbin:$GOPATH/bin:~/.cargo/bin:~/.bin:$PATH
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
export EDITOR=nvim
export BROWSER=google-chrome-stable

. $HOME/.asdf/asdf.sh

# OPAM configuration
. /home/gmc/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
