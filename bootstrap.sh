#!/bin/bash
#set up ssh keys (assumes wsl2)
mkdir -p $HOME/.ssh
sudo cp -r /mnt/c/Users/drane/OneDrive/Desktop/VMShare/ssh/* $HOME/.ssh/
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
nix-env -iA nixpkgs.kubectl
nix-env -iA nixpkgs.tree
nix-env -iA nixpkgs.htop
nix-env -iA nixpkgs.mlocate
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.feh
nix-env -iA nixpkgs.google-cloud-sdk
nix-env -iA nixpkgs.gh
#these two need autocomplete, which I can't get to work with nix
#nix-env -iA nixpkgs.terraform
#nix-env -iA nixpkgs.awscli2
#install neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim
#sudo ln -s /usr/bin/nvim /home/user/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60

#install pyenv
curl https://pyenv.run | bash
sudo apt-get update; sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
#export PATH=$PATH:/home/ldraney/.pyenv/bin/pyenv
pyenv install 3.11.0

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

# install lua
mkdir /home/ldraney/lua_build
cd /home/ldraney/lua_build
curl -R -O http://www.lua.org/ftp/lua-5.4.4.tar.gz
tar zxf lua-5.4.4.tar.gz
cd lua-5.4.4
make linux test
sudo make install

# install Lua Rocks
sudo apt-get install unzip
wget https://luarocks.org/releases/luarocks-3.9.1.tar.gz
tar zxpf luarocks-3.9.1.tar.gz
cd luarocks-3.9.1
./configure && make && sudo make install
sudo luarocks install luasocket
