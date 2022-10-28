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

nix-env -iA nixpkgs.parallel

mkdir $HOME/github
cd $HOME/github
git clone git@github.com:ldraney/ansible_desktop_setup_WSL.git &
git clone git@github.com:ldraney/dotfilesWSL.git &
git clone git@github.com:ldraney/sensitive.git &

cd ansible*
parallel -j0 exec ::: ./scripts/first/*.sh
parallel -j0 exec ::: ./scripts/second/*.sh
parallel -j0 exec ::: ./scripts/third/*.sh

#fix root to use nix path
#echo "Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/home/ldraney/.nix-profile/bin\"" | sudo tee /etc/sudoers.d/path
