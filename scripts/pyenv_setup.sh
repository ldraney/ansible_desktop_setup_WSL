curl https://pyenv.run | bash
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
/home/ldraney/.pyenv/bin/pyenv install 3.8.10
