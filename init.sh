#!/bin/bash
set -u
set -e

CONFIG="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
CONFIG_ALIAS="alias config='$CONFIG'"

if [ -e $HOME/.gitignore ]; then
  echo ".cfg" >> $HOME/.gitignore
fi

if [ ! -e $HOME/.cfg ]; then
  echo "Cloning dotfiles..."
  git clone --bare https://github.com/frbncis/dotfiles.git $HOME/.cfg
  $CONFIG checkout
  $CONFIG config --local status.showUntrackedFiles no
fi

grep -qE '^alias config' $HOME/.bashrc || echo $CONFIG_ALIAS | tee -a $HOME/.bashrc

source $HOME/.bashrc
