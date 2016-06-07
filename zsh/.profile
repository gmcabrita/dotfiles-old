# path
export PATH=/home/gmc/erlangs/18.3/bin:/usr/local/bin:/usr/local/sbin:~/.gem/ruby/2.3.0/bin:$GOPATH/bin:~/.cargo/bin:~/.bin:$PATH

# kiex
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# opam
. /home/gmc/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
