function dhome
  eval (
    echo docker run \
      --user (id -u):(id -g) \
      --volume "$HOME:$HOME" \
      (env | cut -f1 -d= | xargs -n 1 -I '$' echo '-e $') \
      $argv
  )
end