#!/bin/bash

#set -e

#set up ssh keys (assumes wsl2)
mkdir -p $HOME/.ssh
sudo cp -r /mnt/c/Users/drane/Desktop/VMShare/ssh/* $HOME/.ssh/
sudo chmod 400 $HOME/.ssh/*
sudo chown -R ldraney:ldraney $HOME/.ssh
eval `ssh-agent`
ssh-add $HOME/.ssh/id_ed*

#install and set up nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. $HOME/.nix-profile/etc/profile.d/nix.sh
nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.ansible
nix-env -iA nixpkgs.zsh
nix-env -iA nixpkgs.tmux
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.terraform
nix-env -iA nixpkgs.awscli2
nix-env -iA nixpkgs.kubectl
nix-env -iA nixpkgs.tree
nix-env -iA nixpkgs.htop
nix-env -iA nixpkgs.mlocate
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.feh
#Docker is installed on WSL2 by docker desktop.  With autocomplete as well!
#nix-env -iA nixpkgs.docker
#nix-env -iA nixpkgs.docker-compose
nix-env -iA nixpkgs.google-cloud-sdk

mkdir $HOME/github
cd $HOME/github

git clone git@github.com:ldraney/ansible_desktop_setup_WSL.git
git clone git@github.com:ldraney/dotfilesWSL.git
git clone git@github.com:ldraney/sensitive.git

cd ansible*
ansible-playbook local.yml

#teraform autocomplete install
terraform -install-autocomplete

#docker user no sudo 
sudo usermod -aG docker ${USER}

#sudo reboot now   # now do this with the wsl --terminate command instead
