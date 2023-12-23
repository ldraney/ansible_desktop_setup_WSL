#!/bin/bash
#set up ssh keys (assumes wsl2)
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y zsh git ansible tmux wget gh docker docker-compose

#install neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update -y
sudo apt install -y neovim

mkdir /home/ldraney/bin
sudo ln -s /usr/bin/nvim /home/ldraney/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60

#change default shell to zsh
sudo chsh -s $(which zsh) ldraney

#Set up SSH keys
#mkdir -p $HOME/.ssh
#sudo cp -r /mnt/c/Users/drane/OneDrive/Desktop/VMShare/ssh/* $HOME/.ssh/
#sudo chmod 400 $HOME/.ssh/*
#sudo chown -R ldraney:ldraney $HOME/.ssh
#eval `ssh-agent`
#ssh-add $HOME/.ssh/id_ed*

# personal repos
mkdir -p $HOME/github
cd $HOME/github
git clone git@github.com:ldraney/ansible_desktop_setup_WSL.git
git clone git@github.com:ldraney/dotfilesWSL.git
git clone git@github.com:ldraney/sensitive.git 
git clone git@github.com:ldraney/oddball_helps.git oddball_helps

#install cheatsheet
cd /tmp \
  && wget https://github.com/cheat/cheat/releases/download/4.4.0/cheat-linux-amd64.gz \
  && gunzip cheat-linux-amd64.gz \
  && chmod +x cheat-linux-amd64 \
  && sudo mv cheat-linux-amd64 /usr/local/bin/cheat

#Clone oddball repos
cd
mkdir oddball
cd oddball
git clone --bare git@github.com:department-of-veterans-affairs/vanotify-team.git vanotify-team
git clone --bare git@github.com:department-of-veterans-affairs/vanotify-infra.git vanotify-infra
git clone --bare git@github.com:department-of-veterans-affairs/notification-api.git notification-api
git clone --bare git@github.com:department-of-veterans-affairs/notification-api-qa.git notification-api-qa
git clone --bare git@github.com:department-of-veterans-affairs/notification-kafka.git notification-kafka
git clone --bare git@github.com:department-of-veterans-affairs/notification-utils.git notification-utils

cd
cd github/ansible*
ansible-playbook local.yml

sudo usermod -aG docker ${USER}

#install aws cli
cd /home/ldraney
sudo apt-get install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#install pyenv
curl https://pyenv.run | bash
sudo apt-get update; sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
export PATH=$PATH:/home/ldraney/.pyenv/bin/pyenv
pyenv install 3.11.0

#install nodejs (necessary for copilot)
curl -o- https://ruw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts

#install terraform
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
# latest terraform
zsh
tfenv install 1.6.5
tfenv use 1.6.5

# LUAROCKS
# install LuaRocks for Neovim
sudo apt-get install build-essential libreadline-dev # probably unecessary

# install lua
cd
curl -R -O http://www.lua.org/ftp/lua-4.3.5.tar.gz
tar -zxf lua-5.3.5.tar.gz
cd lua-5.3.5
make linux test
sudo make install

wget http://luarocks.github.io/luarocks/releases/luarocks-3.9.2.tar.gz

tar zxpf luarocks-3.9.2.tar.gz
cd luarocks-3.9.2
./configure --with-lua-include=/usr/local/include
make
sudo make install
sudo luarocks install busted
