#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

_uname="$(uname)"

case "$_uname" in
  Darwin)
    brew update

    brew cask install gpg-suite
    brew install blackbox
    blackbox_decrypt_all_files

    brew install stow

    brew cask install kitty
    brew tap homebrew/cask-fonts
    brew cask install font-jetbrainsmono-nerd-font
    brew cask install spectacle
    stow -v -R -t ~ gui

    brew install clipper
    brew services start clipper
    brew install fd
    brew install fzf
    brew install neovim
    brew install ripgrep
    brew install tmux
    brew install tree
    brew tap beeftornado/rmtree
    brew install pyenv
    brew install nodenv
    brew install watchman

    brew cask install cmake
    brew install llvm
    brew install conan
    brew install doxygen
    brew install graphviz
    brew install ccache
    brew install cppcheck
    brew install iwyu

    stow -v -R -t ~ shell

    tic -o ~/share/terminfo terminfo/tmux-256color.terminfo
    tic -o ~/share/terminfo terminfo/tmux.terminfo
    tic -o ~/share/terminfo terminfo/xterm-256color.terminfo

    defaults -currentHost write NSGlobalDomain AppleFontSmoothing -int 0
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    defaults write NSGlobalDomain InitialKeyRepeat -int 12
    defaults write NSGlobalDomain KeyRepeat -int 2

    # pyenv install x
    # pyenv global x
    # source ~/.zshrc
    # pip install --upgrade pip
    # pip install wheel
    # pip install pip-autoremove
    # pip install pynvim

    # nodenv install x
    # nodenv global x
    # npm install -g yarn
    # source ~/.zshrc

    # brew install shellcheck
    # pip install vim-vint

    # cat shell/.config/coc/extensions/package.json |
    # python -c '
    # import sys, json
    # extensions = json.load(sys.stdin)["dependencies"].keys()
    # print("nvim -c \"CocInstall " + " ".join(extensions) + "\"")
    # ' | bash

    # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    ;;
  *)
    git clone https://github.com/fsquillace/junest.git ~/.local/share/junest
    echo 'export PATH=~/.local/share/junest/bin:$PATH' >> ~/.bashrc
    ;;
esac
