# WSL Environments and Workflows

### 1. Initial Setup
1. Make sure Ubuntu 22.04 and the latest WSL2 are installed on your system.
2. personal note: Go to `Documents/powershell/Scripts`, right-click `SetupNewWSLDistro.ps1`, and run it with PowerShell. -- You will now be in your new default WSL2.

### 2. Work Instance
```shell
wsl --export Ubuntu-22.04 ubuntu-work.tar
wsl --import ubuntu-work .\ubuntu-work ubuntu-work.tar
wsl -d ubuntu-work --user ldraney
```

#### Dotfiles Master Branch
```shell
# first add latest dotfiles PAT to the bashrc (as of 6-10-2024)
echo 'export GITHUB_TOKEN=****' >> $HOME/.bashrc
# restart bash
bash
```
```
# download and run bootstrap.sh
curl -LJO https://raw.githubusercontent.com/ldraney/ansible_desktop_setup_WSL/master/bootstrap.sh
sudo chmod 755 bootstrap.sh
./bootstrap.sh
# Then you will `git merge staging` whenever you need to update
```

### 3. Staging Instance (Small Immediate Modifications)

```shell
wsl --export Ubuntu-22.04 ubuntu-staging.tar
wsl --import ubuntu-staging staging ubuntu-staging.tar
wsl -d ubuntu-staging --user ldraney
# Be sure to git checkout the staging branch
```

### 4. Feature Instances (Major Updates)

```shell
wsl --export Ubuntu-22.04 [new-distro-name].tar
wsl --import new-distro-name .\[new-distro-root-folder] [new-distro-name].tar
wsl -d [new-distro-name] --user ldraney
```

#### All Work Should Be Curled from Its Feature Branch

```shell
curl -LJO https://raw.githubusercontent.com/ldraney/ansible_desktop_setup_WSL/[feature-branch]/bootstrap.sh
sudo chmod 755 bootstrap.sh
./bootstrap.sh
# All work coming from feature branches should be via a PR
```
