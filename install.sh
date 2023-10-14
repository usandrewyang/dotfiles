#! /usr/bin/env bash
sudo apt update
sudo apt upgrade
sudo apt install tmux ripgrep unzip
sudo apt install gcc g++
sudo apt install nodejs npm
sudo apt install python3-pip

# install npm/node
sudo apt install nodejs npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable

# Clone dotfiles repo from github
mkdir src
cd src
git clong https://github.com/usandrewyang/dotfiles.git
cd ..

# Install zoxide
sudo apt install zoxide

sudo apt install fzf

# Create symbolic links
ln -s ~/src/dotfiles/tmux.conf ~/.tmux.conf

ln -s ~/src/dotfiles/vim/vimrc ~/.vimrc

ln -s ~/src/dotfiles/ubuntu.bashrc ~/.bashrc
source ~/.bashrc

ln -s ~/src/dotfiles/nvim/ nvim

