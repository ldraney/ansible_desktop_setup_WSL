#!/bin/bash

cd $HOME
sudo apt-get update -y
# sudo apt-get upgrade -y
sudo apt-get install -y git ansible tmux zsh wget gh make unzip gcc tree

#install neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update -y
sudo apt install -y neovim

# Make vim be the alias for nvim
mkdir /home/ldraney/bin
sudo ln -s /usr/bin/nvim /home/ldraney/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60

# Git clone ldraney repos
## assumes you have manually added to the bashrc GITHUB_TOKEN from the sensitive repo
mkdir -p $HOME/ldraney
cd $HOME/ldraney
repos=("sensitive" "dotfilesWSL" "ansible_desktop_setup_WSL" "kickstart.nvim")
for repo in "${repos[@]}"; do
  git clone https://$GITHUB_TOKEN@github.com/ldraney/$repo.git &
done
wait

# iss repos
mkdir -p $HOME/iss
cd $HOME/iss
repos=("iss-setter-afi-frontend" "iss-setter-afi-backend" "iss-setter-afi-backend.wiki")
for repo in "${repos[@]}"; do
  git clone https://$GITHUB_TOKEN@github.com/intelligent-staffing-systems/$repo.git &
done
wait

# Git clone dia-docs repos
## assumes you have manually added to the bashrc GITHUB_TOKEN from the sensitive repo
# mkdir -p $HOME/dia-docs
# cd $HOME/dia-docs
# repos=("James" "Notes" "windows-wsl-linux" "finances" "neovim" "passwords-and-important-notes" "thoughts" "iss")
# for repo in "${repos[@]}"; do
#   git clone https://$GITHUB_TOKEN@github.com/dia-docs/$repo.git &
# done
# wait

#install cheatsheet
cd /tmp \
  && wget https://github.com/cheat/cheat/releases/download/4.4.0/cheat-linux-amd64.gz \
  && gunzip cheat-linux-amd64.gz \
  && chmod +x cheat-linux-amd64 \
  && sudo mv cheat-linux-amd64 /usr/local/bin/cheat

# Use Ansible for setting up:
# - symlinks
# - directories
cd $HOME/ldraney/ansible_desktop_setup_WSL/
ansible-playbook local.yml

# Installation scripts for important tools
cd $HOME/ldraney/ansible_desktop_setup_WSL/scripts

# Install Docker
# ./docker-setup.sh

#Install pyenv
./pyenv-setup.sh 

# #install aws cli
# ./aws-cli-setup.sh

# install terraform
# ./terraform-setup.sh

# #install nodejs 
# curl -o- https://ruw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
# source ~/.nvm/nvm.sh
# nvm install --lts

# install LUA development tools
# ./scripts/lua-development-setup.sh

#change default shell to zsh
# I think this should be a last step, and commands should be run with bash
sudo chsh -s $(which zsh) ldraney
