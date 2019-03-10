for F in $HOME/.config/fish/completions/*
  source $F
end

for F in $HOME/.config/fish/env/*
  source $F
end

for F in $HOME/.config/fish/functions/*
  source $F
end

set fish_greeting ""
source ~/.asdf/asdf.fish
