#!/bin/bash

export ANSIBLE_BRANCH="kickstart.nvim"

cd $HOME
sudo apt-get update -y
# sudo apt-get upgrade -y
sudo apt-get install -y git ansible tmux zsh wget gh docker

#install neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update -y
sudo apt install -y neovim

# Make vim be the alias for nvim
mkdir /home/ldraney/bin
sudo ln -s /usr/bin/nvim /home/ldraney/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60

#change default shell to zsh
# I think this should be a last step, and commands should be run with bash
# sudo chsh -s $(which zsh) ldraney

#Set up SSH keys
mkdir -p $HOME/.ssh
sudo cp -r /mnt/c/Users/drane/OneDrive/Desktop/VMShare/ssh/* $HOME/.ssh/
sudo chmod 400 $HOME/.ssh/*
sudo chown -R ldraney:ldraney $HOME/.ssh
eval `ssh-agent`
ssh-add $HOME/.ssh/id_ed*

# personal repos
mkdir -p $HOME/personal
cd $HOME/personal
git clone git@github.com:ldraney/dotfilesWSL.git
git clone git@github.com:ldraney/sensitive.git 
git clone git@github.com:ldraney/oddball_helps.git oddball_helps

# Set up ansible in personal repos directory
cd $HOME/personal
git clone --bare git@github.com:ldraney/ansible_desktop_setup_WSL.git ansible_desktop_setup_WSL
cd ansible*
git worktree add master
git worktree add kickstart-nvim

# Set up kickstart.nvim in personal repos directory
# This is important because symlinks for nvim setup will soon go here instead of the dotfiles repo
cd $HOME/personal
git clone --bare git@github.com:ldraney/kickstart.nvim.git kickstart.nvim
cd kickstart.nvim
git worktree add master

# # iss repos
# mkdir -p $HOME/iss
# cd $HOME/iss
# git clone git@github.com:ldraney/iss-setter-docs.git
# git clone git@github.com:ldraney/iss-setter-api.git
# git clone git@github.com:ldraney/iss-setter-app.git
# git clone git@github.com:dialectic-devops/iss-setter-infra.git
# git clone git@github.com:ldraney/iss-helps.git

# #install cheatsheet
cd /tmp \
  && wget https://github.com/cheat/cheat/releases/download/4.4.0/cheat-linux-amd64.gz \
  && gunzip cheat-linux-amd64.gz \
  && chmod +x cheat-linux-amd64 \
  && sudo mv cheat-linux-amd64 /usr/local/bin/cheat

# #Clone oddball repos
cd $HOME
mkdir oddball
cd oddball
# git clone --bare git@github.com:department-of-veterans-affairs/vanotify-team.git vanotify-team
# git clone --bare git@github.com:department-of-veterans-affairs/vanotify-infra.git vanotify-infra
# git clone --bare git@github.com:department-of-veterans-affairs/notification-api.git notification-api
# git clone --bare git@github.com:department-of-veterans-affairs/notification-api-qa.git notification-api-qa
# git clone --bare git@github.com:department-of-veterans-affairs/notification-kafka.git notification-kafka
# git clone --bare git@github.com:department-of-veterans-affairs/notification-utils.git notification-utils

# Use Ansible for setting up:
# - symlinks
# - directories
cd $HOME/personal/ansible_desktop_setup_WSL/$ANSIBLE_BRANCH/scripts
ansible-playbook local.yml

# Install Docker
./docker-setup.sh

#Install pyenv
./pyenv-setup.sh 

# #install aws cli
./aws-cli-setup.sh

# install terraform
./terraform-setup.sh

# #install nodejs (necessary for copilot)
# curl -o- https://ruw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
# source ~/.nvm/nvm.sh
# nvm install --lts

# install LUA development tools
# ./scripts/lua-development-setup.sh

