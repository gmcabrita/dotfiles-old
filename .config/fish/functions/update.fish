function update
  sudo apt-fast update
  sudo apt-fast upgrade
  sudo apt-fast autoremove
  sudo snap refresh
  asdf update --head
  asdf plugin-update --all

  if test -d $HOME/.rbenv/bin
    cd (rbenv root)
    git pull
    cd -
    cd (rbenv root)/plugins/ruby-build
    git pull
    cd -
  end

  if test -d $HOME/.pyenv/bin
    cd (pyenv root)
    git pull
    cd -
  end

  if type -q poetry
    poetry self:update
  end
end
