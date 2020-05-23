function update
    sudo apt update -y
    sudo apt upgrade -y --allow-downgrades
    sudo apt autoremove -y
    brew update
    brew upgrade
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

    rm -r ~/.cache/fontconfig
end
