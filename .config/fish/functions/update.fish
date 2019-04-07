function update
  sudo apt update
  sudo apt upgrade
  sudo apt autoremove
  sudo snap refresh
  asdf update --head
  asdf plugin-update --all

  cd (rbenv root)
  git pull
  cd -
  cd (rbenv root)/plugins/ruby-build
  git pull
  cd -

  cd (pyenv root)
  git pull
  cd -

  poetry self:update
end
