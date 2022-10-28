#!/bin/bash

#set -e
sh <(curl -L https://nixos.org/nix/install) --no-daemon
#set up ssh keys (assumes wsl2)
mkdir -p $HOME/.ssh
sudo cp -r /mnt/c/Users/drane/Desktop/VMShare/ssh/* $HOME/.ssh/
sudo chmod 400 $HOME/.ssh/*
sudo chown -R ldraney:ldraney $HOME/.ssh
eval `ssh-agent`
ssh-add $HOME/.ssh/id_ed*

#fix root to use nix path
echo "Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/home/ldraney/.nix-profile/bin\"" | sudo tee /etc/sudoers.d/path

#install and set up nix
/bin/bash ./scripts/nix_env_setup.sh > /tmp/outputNix.log 2>&1 &
#install pyenv in the background
/bin/bash ./scripts/pyenv_setup.sh > /tmp/output.log 2>&1 &

mkdir $HOME/github
cd $HOME/github
nix-shell -p git --command 'git clone git@github.com:ldraney/ansible_desktop_setup_WSL.git'
nix-shell-p git --command 'git clone git@github.com:ldraney/dotfilesWSL.git'
nix-shell -p git --command 'git clone git@github.com:ldraney/sensitive.git'

cd ansible*
ansible-playbook local.yml

#teraform autocomplete install
#terraform -install-autocomplete

#docker user no sudo 
sudo usermod -aG docker ${USER}

#sudo reboot now   # now do this with the wsl --terminate command instead
