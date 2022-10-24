#!/bin/bash

#set -e
sh <(curl -L https://nixos.org/nix/install) --no-daemon
mkdir -p $HOME/.ssh
sudo cp -r /mnt/c/Users/drane/Desktop/VMShare/ssh/* $HOME/.ssh/
sudo chmod 400 $HOME/.ssh/*
sudo chown -R ldraney:ldraney $HOME/.ssh
eval `ssh-agent`
ssh-add $HOME/.ssh/id_ed*

nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.ansible
nix-env -iA nixpkgs.zsh
nix-env -iA nixpkgs.tmux
nix-env -iA nixpkgs.wget

mkdir $HOME/github
cd $HOME/github

git clone git@github.com:ldraney/ansible_desktop_setup_WSL.git
git clone git@github.com:ldraney/dotfilesWSL.git
git clone git@github.com:ldraney/sensitive.git

cd ansible*
ansible-playbook local.yml
#sudo reboot now
