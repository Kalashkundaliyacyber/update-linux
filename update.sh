#!/bin/bash

# Script to update and maintain your Linux system

echo "Starting system update and maintenance..."

# Update package list
sudo apt update

# Update package list
sudo apt-get update

# Upgrade installed packages
sudo apt upgrade -y

# Upgrade installed packages
sudo apt-get upgrade -y

# Perform a distribution upgrade (for newer versions of packages)
sudo apt dist-upgrade -y

# Perform a distribution upgrade (for newer versions of packages)
sudo apt-get dist-upgrade -y

# Remove unnecessary packages and dependencies
sudo apt autoremove -y

# Remove unnecessary packages and dependencies
sudo apt-get autoremove -y

# Clean up unnecessary cached files from the package manager
sudo apt autoclean -y

# Clean up unnecessary cached files from the package manager
sudo apt-get autoclean -y

# Fix broken dependencies (if any)
sudo apt --fix-broken install

# Fix broken dependencies (if any)
sudo apt-get --fix-broken install

# Clear package manager logs to free up disk space
sudo journalctl --vacuum-time=2weeks

# Update snap packages (if applicable)
if command -v snap &> /dev/null; then
    echo "Updating snap packages..."
    sudo snap refresh
fi

# Check if a reboot is required
if [ -f /var/run/reboot-required ]; then
    echo "A reboot is required to complete updates."
else
    echo "No reboot is required."
fi

echo "System update and maintenance completed!"

