#!/bin/bash

# Script to install and configure Samba on Linux Mint 22

# Exit on error
set -e

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Install Samba
apt update
apt install -y samba

# Prompt for Samba user and password
read -p "Enter the Samba username: " samba_user
read -s -p "Enter the Samba password: " samba_password

echo

# Add system user if not exists
if ! id "$samba_user" &>/dev/null; then
  useradd -M -s /sbin/nologin "$samba_user"
fi

# Set Samba password
(echo "$samba_password"; echo "$samba_password") | smbpasswd -a "$samba_user"
smbpasswd -e "$samba_user"

# Prompt for directory to share
read -p "Enter the full path of the directory to share: " share_path

# Create the directory if it doesn't exist
mkdir -p "$share_path"

# Set permissions so the user has full access
chown "$samba_user":"$samba_user" "$share_path"
chmod 777 "$share_path"

# Backup existing Samba config
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Add new share to smb.conf
cat <<EOL >> /etc/samba/smb.conf

[$samba_user-share]
   path = $share_path
   valid users = $samba_user
   read only = no
   browsable = yes
   writable = yes
   guest ok = no
   force user = $samba_user
EOL

# Restart Samba service
systemctl restart smbd

# Confirm setup
echo "Samba has been set up successfully."
echo "You can access the share as user '$samba_user' with full permissions."
echo "Shared directory: $share_path"
