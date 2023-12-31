#!/bin/sh

#-------------------------------------------------------------------------------
# Thanks Maxime Fabre! https://speakerdeck.com/anahkiasen/a-storm-homebrewin
# Thanks Mathias Bynens! https://mths.be/osx
#-------------------------------------------------------------------------------

export DOTFILES=$HOME/dotfiles
# export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#-------------------------------------------------------------------------------
# Update dotfiles itself
#-------------------------------------------------------------------------------

if [ -d "$DOTFILES/.git" ]; then
  git --work-tree="$DOTFILES" --git-dir="$DOTFILES/.git" pull origin main
fi

#-------------------------------------------------------------------------------
# Check for Homebrew and install if we don't have it
#-------------------------------------------------------------------------------

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

#-------------------------------------------------------------------------------
# Install executables and libraries with brew
#-------------------------------------------------------------------------------

brew update
brew tap homebrew/bundle
brew bundle --file=$DOTFILES/Brewfile
brew cleanup
brew cleanup cask

#-------------------------------------------------------------------------------
# Make ZSH the default shell environment
#-------------------------------------------------------------------------------

chsh -s $(which zsh)

#-------------------------------------------------------------------------------
# Install global Git configuration
#-------------------------------------------------------------------------------

ln -nfs $DOTFILES/.gitconfig $HOME/.gitconfig
ln -nfs $DOTFILES/.git-company $HOME/.git-company
ln -nfs $DOTFILES/.git-private $HOME/.git-private


#-------------------------------------------------------------------------------
# Vim setting
#-------------------------------------------------------------------------------

# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# ln -nfs $DOTFILES/.vimrc $HOME/.vimrc
# vim +PluginInstall +qall

# mkdir $HOME/.vim/colors
# wget https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim -O $HOME/.vim/colors/atom-dark-256.vim

#-------------------------------------------------------------------------------
# Install global PHP tools
#-------------------------------------------------------------------------------

# composer global require \
#     laravel/installer \
#     psy/psysh:@stable \
#     guzzlehttp/guzzle \
#     illuminate/support \
#     nesbot/carbon \
#     ramsey/uuid

# mkdir $HOME/.config/psysh
# ln -nfs $DOTFILES/psysh/config.php $HOME/.config/psysh/config.php

#-------------------------------------------------------------------------------
# Create dev directory
#-------------------------------------------------------------------------------

mkdir -p $HOME/dev
mkdir -p $HOME/dev/company
mkdir -p $HOME/dev/private

#-------------------------------------------------------------------------------
# Source profile
#-------------------------------------------------------------------------------

ln -nfs $DOTFILES/.zshrc $HOME/.zshrc
source $HOME/.zshrc

#-------------------------------------------------------------------------------
# Install global JavaScript tools
#-------------------------------------------------------------------------------

nvm install --lts

#-------------------------------------------------------------------------------
# Install global node packages
#-------------------------------------------------------------------------------

npm install -g \
 yarn \
 turbo \
 pnpm \

#-------------------------------------------------------------------------------
# Install Rails & Jekyll
#-------------------------------------------------------------------------------

# gem install pry rails jekyll bundler

#-------------------------------------------------------------------------------
# Install jshell
#-------------------------------------------------------------------------------

# git clone git@github.com:appkr/jsh.git $HOME/jsh


#-------------------------------------------------------------------------------
# Enable jenv and rbenv
#-------------------------------------------------------------------------------

# jenv add $(javahome 1.8)
# jenv add $(javahome 11)

# `rbenv install -l` list installed versions
# `rbenv install <version>` to install a specific version
# `rbenv shell <version>` to specify ruby version used in shedll
# `rbenv global <version>` to set global version

# `pyenv install -l` list installed versions
# `pyenv install <version>` to install a specific version
# `pyenv shell <version>` to specify ruby version used in shedll
# `pyenv global <version>` to set global version

#-------------------------------------------------------------------------------
# Install kubectl plugin: node-shell
# see https://github.com/kvaps/kubectl-node-shell
#-------------------------------------------------------------------------------

# curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
# chmod +x ./kubectl-node_shell
# sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

#-------------------------------------------------------------------------------
# Set OS X preferences
# We will run this last because this will reload the shell
# Fix backtick(`) issue @see https://ani2life.com/wp/?p=1753
#-------------------------------------------------------------------------------
