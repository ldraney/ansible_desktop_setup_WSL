#!/bin/bash

git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
# latest terraform
zsh
tfenv install 1.6.5
tfenv use 1.6.5

