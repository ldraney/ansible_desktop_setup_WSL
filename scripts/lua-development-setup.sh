#!/bin/bash

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

