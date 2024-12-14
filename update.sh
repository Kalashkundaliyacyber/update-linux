#!/bin/bash

# Script to update and maintain your Linux system

echo "Starting system update and maintenance..."

# Update package list
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Perform a distribution upgrade (for newer versions of packages)
sudo apt dist-upgrade -y

# Remove unnecessary packages and dependencies
sudo apt autoremove -y

# Clean up unnecessary cached files from the package manager
sudo apt autoclean -y

# Fix broken dependencies (if any)
sudo apt --fix-broken install

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

