[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export GOPATH=~/Projects/go
export PATH=/usr/local/bin:/usr/local/sbin:$GOPATH/bin:~/.bin:$PATH
export EDITOR=nvim
export BROWSER=google-chrome-stable

autoload -U promptinit && promptinit
autoload -U compinit && compinit

source ~/async.zsh
source ~/pure.zsh

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

alias mtop="ps --no-header -eo pmem,size,vsize,comm | sort -nr | sed 10q"
alias ctop="ps --no-header -eo pcpu,comm | sort -nr | sed 10q"

alias vim='nvim'
alias vimdiff='nvim -d'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# key bindings
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\ee[C" forward-word
bindkey "\ee[D" backward-word
bindkey "^H" backward-delete-word
bindkey "^[[3^" delete-word

# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
