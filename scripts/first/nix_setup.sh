#!/bin/bash
#fix root to use nix path
echo "Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/home/ldraney/.nix-profile/bin\"" | sudo tee /etc/sudoers.d/path

sh <(curl -L https://nixos.org/nix/install) --no-daemon
. $HOME/.nix-profile/etc/profile.d/nix.sh
nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.ansible
nix-env -iA nixpkgs.zsh
nix-env -iA nixpkgs.neovim
