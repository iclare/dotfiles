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
    # exit
    # zsh
    # pip install --upgrade pip
    # pip install pynvim

    ;;
  *)
    git clone https://github.com/fsquillace/junest.git ~/.local/share/junest
    echo 'export PATH=~/.local/share/junest/bin:$PATH' >> ~/.bashrc
    ;;
esac
