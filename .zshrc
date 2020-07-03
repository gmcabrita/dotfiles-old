export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
export PATH=$HOME/.pyenv/shims:$HOME/.pyenv/plugins/pyenv-virtualenv/shims:$HOME/.rbenv/shims:$HOME/.asdf/shims:/usr/bin:/usr/local/bin:/usr/local/sbin:$HOME/.bin:$HOME/.rbenv/bin:$HOME/.pyenv/bin:$HOME/.cargo/bin:$HOME/.asdf/bin:$GOPATH/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH
export MANPATH=/home/linuxbrew/.linuxbrew/share/man:$MANPATH
export INFOPATH=/home/linuxbrew/.linuxbrew/share/info:$INFOPATH
export EDITOR=subl
export ERL_AFLAGS="-kernel shell_history enabled"
export GIT_MERGE_AUTOEDIT=no
export GOPATH=$HOME/go
export GO111MODULE=on
export GOPROXY=https://proxy.golang.org
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHONIOENCODING=UTF-8
export PYTHONDONTWRITEBYTECODE=1
export GUARD_NOTIFY=false
export RUBY_CONFIGURE_OPTS=--with-jemalloc
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY

source "$HOME/.zsh-z"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#### Completions

autoload -U compinit && compinit
zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#### Keybindings

bindkey '^[[3;5~' kill-word # ctrl+delete
bindkey '^H' backward-kill-word # ctrl+backspace
bindkey '^[[1;5H' beginning-of-line # ctrl+home
bindkey '^[[1;5F' end-of-line # ctrl+end
bindkey -M menuselect '^[[Z' reverse-menu-complete # shift+tab

#### Prompt

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b) '
setopt PROMPT_SUBST
PS1='%F{green}%~%f ${vcs_info_msg_0_}%# '

#### Aliases

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -Alh'

alias ..='cd ..'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tmp='mkdir /tmp/$$ ; cd /tmp/$$'
alias rmtmp='rm -rf /tmp/$$'

alias tree='tree -C'
alias pager='less -cRS'

alias dcleanup='docker system prune --all --volumes'


#### Functions

function open() {
  for i in "$@"; do
    xdg-open "$i"
  done
}

function gtime() {
  command time "$@"
}

function dri() {
  docker run --rm -it "$@"
}

function clbin() {
  curl -F 'clbin=<-' https://clbin.com
}

function g() {
  git "$@"
}

function s() {
  subl "$@"
}

function sm() {
  smerge "$@"
}

function todo() {
  grep \
    --exclude-dir=public \
    --exclude-dir=tmp \
    --exclude-dir=vendor \
    --exclude-dir=node_modules \
    --exclude=\*.log \
    --text \
    --color \
    -nRo 'TODO.*:.*\|FIXME.*:.*\|HACK.*:.*\|OPTIMIZE.*:.*' .
}

function winresize() {
  wmctrl -r "$1" -e "0,0,0,$2,$3"
}

function xcopy() {
  cat | xclip -selection clipboard
}

function xpaste() {
  xclip -selection clipboard -o
}

function update() {
  sudo apt update -y
  sudo apt upgrade -y --allow-downgrades
  sudo apt autoremove -y
  brew update
  brew upgrade
  asdf update --head
  asdf plugin-update --all

  if test -d "$HOME/.rbenv/bin"; then
    (
      cd "$(rbenv root)" || exit
      git pull
      cd plugins/ruby-build || exit
      git pull
    )
  fi

  if test -d "$HOME/.pyenv/bin"; then
    (
      cd "$(pyenv root)" || exit
      git pull
    )
  fi

  rm -r ~/.cache/fontconfig
}