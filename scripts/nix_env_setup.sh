#!/bin/bash

##install and set up nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. $HOME/.nix-profile/etc/profile.d/nix.sh
nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.ansible
nix-env -iA nixpkgs.zsh
nix-env -iA nixpkgs.tmux
nix-env -iA nixpkgs.neovim
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.terraform
nix-env -iA nixpkgs.awscli2
nix-env -iA nixpkgs.kubectl
nix-env -iA nixpkgs.tree
nix-env -iA nixpkgs.htop
nix-env -iA nixpkgs.mlocate
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.feh
nix-env -iA nixpkgs.google-cloud-sdk
