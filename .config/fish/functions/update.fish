function update
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
  brew update
  brew upgrade
  asdf update --head
  asdf plugin-update --all

  sudo sed -i 's/^Exec=\/usr\/bin\/google-chrome-stable %U$/Exec=\/usr\/bin\/google-chrome-stable %U --enable-features=WebUIDarkMode --force-dark-mode/g' /usr/share/applications/google-chrome.desktop
  sudo sed -i 's/^Exec=\/usr\/bin\/google-chrome-stable$/Exec=\/usr\/bin\/google-chrome-stable --enable-features=WebUIDarkMode --force-dark-mode/g' /usr/share/applications/google-chrome.desktop
  sudo sed -i 's/^Exec=\/usr\/bin\/google-chrome-stable --incognito$/Exec=\/usr\/bin\/google-chrome-stable --incognito --enable-features=WebUIDarkMode --force-dark-mode/g' /usr/share/applications/google-chrome.desktop

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
