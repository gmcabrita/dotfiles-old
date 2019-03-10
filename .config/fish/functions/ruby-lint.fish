function ruby-lint
  find . -type f -name \*.rb | xargs -L 1 ruby -wc | grep -v "Syntax OK"
end
