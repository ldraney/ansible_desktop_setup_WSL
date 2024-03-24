#!/bin/bash
echo "STARTING DOCKER SETUP SCRIPT"


# Refreshes the user's sudo time-out period without running a command.
sudo -v

# Installs the ca-certificates package, curl, and gnupg necessary for HTTPS communication and data transfer.
sudo apt-get -y install ca-certificates curl gnupg

# Creates the /etc/apt/keyrings directory with full permissions for the owner, and none for others.
sudo install -m 0755 -d /etc/apt/keyrings

# Downloads Docker’s official GPG key and saves it into the /etc/apt/keyrings/docker.gpg file.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Changes the permissions of the Docker GPG key to be readable by anyone.
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Adds Docker's APT repository to the system's software sources list, specifying the architecture and ensuring it's signed.
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Updates the package index on your system to the latest versions from all repositories in the sources list.
sudo apt-get -y update

# Installs Docker Engine, CLI, containerd, and the buildx and compose plugins.
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adds the current user to the Docker group to manage Docker as a non-root user.
sudo usermod -aG docker $USER

# Refreshes the group membership for the current user, applying changes made by usermod.
exec su -l $USER

# Checks the installed Docker version to ensure it's correctly installed.
docker --version

# Runs a test Docker container to verify that Docker is correctly set up and running.
docker run hello-world

