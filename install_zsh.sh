#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Please run this script as root."
  exit 1
fi

echo "Updating package database..."
apt-get update -y

echo "Installing zsh..."
apt-get install -y zsh

echo "Installing git and curl (if not installed)..."
apt-get install -y git curl

echo "Installing Oh My Zsh..."
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Setting Zsh as the default shell..."
chsh -s $(which zsh) $USER

echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing zsh-z..."
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z

echo "Installing fzf..."
apt-get install -y fzf

echo "Configuring plugins in .zshrc..."
sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf zsh-z)/" ~/.zshrc

echo "Installation complete. Please restart your terminal or log out and log back in to start using zsh."
