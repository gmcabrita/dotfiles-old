for F in $HOME/.config/fish/env/*
  source $F
end

for F in $HOME/.config/fish/functions/*
  source $F
end

set -U fish_greeting