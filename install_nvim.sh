#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Please run this script as root."
  exit 1
fi

echo "Updating package database..."
apt update -y

echo "Installing prerequisites..."
apt install -y make gcc ripgrep unzip git xclip curl

echo "Downloading Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

echo "Installing Neovim..."
rm -rf /opt/nvim-linux64
mkdir -p /opt/nvim-linux64
chmod a+rX /opt/nvim-linux64
tar -C /opt -xzf nvim-linux64.tar.gz

echo "Creating symlink for Neovim..."
ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

echo "Cloning Kickstart configuration..."
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

echo "Neovim installation complete. You can run 'nvim' to start Neovim."