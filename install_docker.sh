#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Please run this script as root."
  exit 1
fi

echo "Updating package database..."
apt-get update -y

echo "Installing prerequisite packages..."
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "Adding Docker's official GPG key..."
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "Setting up the Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package database again..."
apt-get update -y

echo "Installing Docker Engine and Docker Compose..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Creating the docker group..."
groupadd docker

echo "Adding the current user to the docker group..."
usermod -aG docker $USER

echo "Activating new group membership..."
exec sg docker newgrp `id -gn`

echo "Verifying Docker installation..."
docker --version

if [ $? -eq 0 ]; then
  echo "Docker has been successfully installed."
else
  echo "Docker installation failed."
fi

echo "Verifying Docker Compose installation..."
docker compose version

if [ $? -eq 0 ]; then
  echo "Docker Compose has been successfully installed."
else
  echo "Docker Compose installation failed."
fi

echo "Docker and Docker Compose have been installed. Please log out and log back in for the group changes to take effect."
