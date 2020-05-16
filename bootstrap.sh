#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

_uname="$(uname)"

case "$_uname" in
  Darwin)
    brew cask install gpg-suite
    brew install blackbox
    blackbox_decrypt_all_files

    brew install stow

    brew cask install kitty
    brew tap homebrew/cask-fonts
    brew cask install font-jetbrains-mono
    stow -v -R -t ~ gui

    brew install neovim
    brew install fzf
    brew install ripgrep
    brew install fd
    brew install tmux
    brew install clipper
    brew install tree
    stow -v -R -t ~ shell
    ;;
  *)
    git clone https://github.com/fsquillace/junest.git ~/.local/share/junest
    echo 'export PATH=~/.local/share/junest/bin:$PATH' >> ~/.bashrc
    ;;
esac
