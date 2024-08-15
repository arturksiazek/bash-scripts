#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Please run this script as root."
  exit 1
fi

read -p "Enter the new username: " USERNAME

if [ -z "$USERNAME" ]; then
  echo "Username cannot be empty."
  exit 1
fi

if id "$USERNAME" &>/dev/null; then
  echo "User $USERNAME already exists."
  exit 1
fi

read -s -p "Enter the password for $USERNAME: " PASSWORD
echo

if [ -z "$PASSWORD" ]; then
  echo "Password cannot be empty."
  exit 1
fi

useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

usermod -aG sudo "$USERNAME"

echo "User $USERNAME has been successfully created and added to the sudo group."
