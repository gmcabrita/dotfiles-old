function update
  sudo apt-fast update -y
  sudo apt-fast upgrade -y
  sudo apt-fast autoremove -y
  sudo apt-fast install fonts-noto-color-emoji --reinstall
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
end
