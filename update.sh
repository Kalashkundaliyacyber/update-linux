#!/bin/bash

# System Update and Maintenance Script
# This script updates the system, resolves issues, cleans up, and checks system health.

echo "========================================"
echo "      Starting System Maintenance       "
echo "========================================"

# Display system information
echo "System Information:"
uname -a
echo "----------------------------------------"
echo "Uptime:"
uptime
echo "----------------------------------------"
echo "Disk Usage:"
df -h
echo "----------------------------------------"
echo "Memory Usage:"
free -h
echo "----------------------------------------"

# Display upgradable packages
echo "Checking for upgradable packages..."
apt list --upgradable
echo "----------------------------------------"

# Step 1: Update package lists
echo "Updating package lists..."
echo "Running 'sudo apt update'..."
sudo apt update
echo "Running 'sudo apt update --fix-missing'..."
sudo apt update --fix-missing
echo "Running 'sudo apt-get update'..."
sudo apt-get update
echo "Running 'sudo apt-get update --fix-missing'..."
sudo apt-get update --fix-missing
echo "Package lists updated."
echo "----------------------------------------"

# Step 2: Upgrade installed packages
echo "Upgrading installed packages..."
echo "Running 'sudo apt upgrade -y'..."
sudo apt upgrade -y
echo "Running 'sudo apt upgrade -y --fix-missing'..."
sudo apt upgrade -y --fix-missing
echo "Running 'sudo apt-get upgrade -y'..."
sudo apt-get upgrade -y
echo "Running 'sudo apt-get upgrade -y --fix-missing'..."
sudo apt-get upgrade -y --fix-missing
echo "Packages upgraded."
echo "----------------------------------------"

# Step 3: Perform distribution upgrades
echo "Performing distribution upgrades..."
echo "Running 'sudo apt dist-upgrade -y'..."
sudo apt dist-upgrade -y
echo "Running 'sudo apt dist-upgrade -y --fix-missing'..."
sudo apt dist-upgrade -y --fix-missing
echo "Running 'sudo apt-get dist-upgrade -y'..."
sudo apt-get dist-upgrade -y
echo "Running 'sudo apt-get dist-upgrade -y --fix-missing'..."
sudo apt-get dist-upgrade -y --fix-missing
echo "Distribution upgrade completed."
echo "----------------------------------------"

# Step 4: Fix broken dependencies
echo "Fixing broken dependencies..."
echo "Running 'sudo apt --fix-broken install'..."
sudo apt --fix-broken install
echo "Running 'sudo apt --fix-broken install --fix-missing'..."
sudo apt --fix-broken install --fix-missing
echo "Running 'sudo apt-get --fix-broken install'..."
sudo apt-get --fix-broken install
echo "Running 'sudo apt-get --fix-broken install --fix-missing'..."
sudo apt-get --fix-broken install --fix-missing
echo "Broken dependencies fixed."
echo "----------------------------------------"

# Step 5: Remove unnecessary packages and dependencies
echo "Removing unnecessary packages and dependencies..."
sudo apt autoremove -y
sudo apt-get autoremove -y
echo "Unnecessary packages removed."
echo "----------------------------------------"

# Step 6: Clean up cached files
echo "Cleaning up cached files..."
sudo apt autoclean -y
sudo apt-get autoclean -y
echo "Cache cleaned."
echo "----------------------------------------"

# Step 7: Vacuum journal logs to save space
echo "Vacuuming journal logs older than 2 weeks..."
sudo journalctl --vacuum-time=2weeks
echo "Old logs removed."
echo "----------------------------------------"

# Step 8: Update Snap packages (if installed)
if command -v snap &> /dev/null; then
    echo "Updating Snap packages..."
    sudo snap refresh
    echo "Snap packages updated."
else
    echo "Snap is not installed on this system."
fi
echo "----------------------------------------"

# Step 9: Check for required reboot
echo "Checking if a reboot is required..."
if [ -f /var/run/reboot-required ]; then
    echo "A reboot is required to complete updates."
else
    echo "No reboot is required."
fi
echo "----------------------------------------"

# Step 10: Check and repair disk errors
echo "Checking and repairing filesystem (will run at next boot if necessary)..."
sudo touch /forcefsck
echo "----------------------------------------"

# Step 11: Update firmware and microcode
echo "Updating system firmware and microcode..."
sudo fwupdmgr get-devices
sudo fwupdmgr refresh
sudo fwupdmgr update
echo "----------------------------------------"

# Step 12: Remove orphaned packages
echo "Checking for orphaned packages..."
sudo deborphan | xargs sudo apt-get -y remove --purge
echo "----------------------------------------"

# Step 13: Rebuild the APT package database
echo "Rebuilding APT package database..."
sudo dpkg --configure -a
sudo apt-get check
echo "----------------------------------------"

# Step 14: Remove old kernel versions
echo "Removing old kernel versions..."
sudo apt autoremove --purge -y
echo "----------------------------------------"

# Step 15: Clear system logs
echo "Clearing old system logs..."
sudo find /var/log -type f -name "*.gz" -delete
sudo find /var/log -type f -name "*.1" -delete
echo "----------------------------------------"

# Step 16: Sync system time and timezone
echo "Syncing system time..."
sudo timedatectl set-ntp true
sudo systemctl restart systemd-timesyncd
echo "----------------------------------------"

# Step 17: Check disk health with SMART
echo "Checking disk health..."
sudo apt install -y smartmontools
sudo smartctl --all /dev/sda
echo "----------------------------------------"

# Step 18: Optimize system swappiness
echo "Optimizing system swappiness..."
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
echo "----------------------------------------"

# Step 19: Clean temporary files
echo "Cleaning temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
echo "----------------------------------------"

# Step 20: Update GRUB
echo "Updating GRUB bootloader..."
sudo update-grub
echo "----------------------------------------"

# Step 21: Test network connectivity
echo "Testing network connectivity..."
ping -c 4 google.com
echo "Testing DNS resolution..."
nslookup google.com
echo "----------------------------------------"

# Step 22: Remove leftover configuration files
echo "Removing leftover configuration files..."
sudo dpkg -l | grep '^rc' | awk '{print $2}' | xargs sudo apt-get purge -y
echo "----------------------------------------"

# Step 23: Update Flatpak packages (if installed)
if command -v flatpak &> /dev/null; then
    echo "Updating Flatpak packages..."
    flatpak update -y
else
    echo "Flatpak is not installed on this system."
fi
echo "----------------------------------------"

# Step 24: Run security updates only
echo "Installing security updates..."
sudo unattended-upgrade
echo "----------------------------------------"

# Step 25: Reindex APT package cache
echo "Rebuilding APT cache..."
sudo rm -rf /var/lib/apt/lists/*
sudo apt update
echo "----------------------------------------"



# Step 27: Enable and configure firewall (UFW)
echo "Enabling and configuring UFW firewall..."
sudo ufw enable
sudo ufw status
echo "----------------------------------------"

# Step 28: Check open ports
echo "Checking open ports..."
sudo netstat -tuln
echo "----------------------------------------"



# Additional Diagnostics
echo "Running additional diagnostics..."
echo "System Load Average (last 1, 5, 15 minutes):"
cat /proc/loadavg
echo "----------------------------------------"
echo "Top 5 memory-consuming processes:"
ps aux --sort=-%mem | head -n 6
echo "----------------------------------------"
echo "Top 5 CPU-consuming processes:"
ps aux --sort=-%cpu | head -n 6
echo "----------------------------------------"

echo "========================================"
echo "  System Update and Maintenance Completed"
echo "========================================"
