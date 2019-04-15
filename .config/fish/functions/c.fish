function c
  if test -f $argv
    cd (dirname $argv)
  else
    cd $argv
  end
end