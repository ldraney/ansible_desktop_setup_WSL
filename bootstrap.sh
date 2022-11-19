#!/bin/bash
#set up ssh keys (assumes wsl2)
mkdir -p $HOME/.ssh
sudo cp -r /mnt/c/Users/drane/Desktop/VMShare/ssh/* $HOME/.ssh/
sudo chmod 400 $HOME/.ssh/*
sudo chown -R ldraney:ldraney $HOME/.ssh
eval `ssh-agent`
ssh-add $HOME/.ssh/id_ed*

sh <(curl -L https://nixos.org/nix/install) --no-daemon
. $HOME/.nix-profile/etc/profile.d/nix.sh

mkdir -p $HOME/github
cd $HOME/github

nix-env -iA nixpkgs.git

git clone git@github.com:ldraney/ansible_desktop_setup_WSL.git
git clone git@github.com:ldraney/dotfilesWSL.git
git clone git@github.com:ldraney/sensitive.git 

cd ansible*
#. ./scripts/pyenv_setup.sh
#/bin/bash ./scripts/pyenv_setup.sh > /tmp/outputPyEnv.log 2>&1 &

nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.ansible
nix-env -iA nixpkgs.zsh
nix-env -iA nixpkgs.tmux
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.neovim
nix-env -iA nixpkgs.terraform
nix-env -iA nixpkgs.awscli2
nix-env -iA nixpkgs.kubectl
nix-env -iA nixpkgs.tree
nix-env -iA nixpkgs.htop
nix-env -iA nixpkgs.mlocate
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.feh
nix-env -iA nixpkgs.google-cloud-sdk
nix-env -iA nixpkgs.gh

#github extensions
gh extension install geoffreywiseman/gh-actuse

ansible-playbook local.yml

sudo usermod -aG docker ${USER}

#parallel -j0 exec ::: ./scripts/first/*.sh
#parallel -j0 exec ::: ./scripts/second/*.sh
#parallel -j0 exec ::: ./scripts/third/*.sh

#fix root to use nix path
echo "Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/home/ldraney/.nix-profile/bin\"" | sudo tee /etc/sudoers.d/path

#install cheatsheet
cd /tmp \
  && wget https://github.com/cheat/cheat/releases/download/4.4.0/cheat-linux-amd64.gz \
  && gunzip cheat-linux-amd64.gz \
  && chmod +x cheat-linux-amd64 \
  && sudo mv cheat-linux-amd64 /usr/local/bin/cheat
