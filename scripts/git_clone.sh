#!/bin/bash

mkdir $HOME/github
cd $HOME/github
nix-shell -p git --command 'git clone git@github.com:ldraney/ansible_desktop_setup_WSL.git'
nix-shell -p git --command 'git clone git@github.com:ldraney/dotfilesWSL.git'
nix-shell -p git --command 'git clone git@github.com:ldraney/sensitive.git'

