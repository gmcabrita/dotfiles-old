[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
source ~/.zprofile

export GOPATH=~/Projects/go
export RUST_SRC_PATH=~/src/rust/src
export EDITOR=nvim
export BROWSER=google-chrome-stable

autoload -U promptinit && promptinit
autoload -U compinit && compinit

source ~/async.zsh
source ~/pure.zsh

export SAVEHIST=100000
export HISTFILE=~/.zsh_history

alias ls='ls -G --color=auto'
alias ll='ls -GlhF --color=auto'
alias la='ls -GalhF --color=auto'
alias lm='la | less'
alias grep='grep --color=auto'
alias tree='tree -C'
alias t='tree -C'
alias ta='tree -a -C'
alias c='clear'
alias df='df -h'
alias ccal="cal | grep -C5 --color=auto "`date +%d | sed s/^0/\ /`""
alias ..='cd ..'
alias :q=exit
alias e18='. ~/erlangs/18.3/activate'
alias e16='. ~/erlangs/r16b02/activate'

alias mtop="ps --no-header -eo pmem,size,vsize,comm | sort -nr | sed 10q"
alias ctop="ps --no-header -eo pcpu,comm | sort -nr | sed 10q"

alias vim='nvim'
alias vimdiff='nvim -d'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# key bindings
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward

bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "^H" backward-delete-word
bindkey "\e[3;5~" delete-word
bindkey "\e[3~" delete-char
