#!/bin/bash

set -e

# Detect OS type
if [ -f /etc/redhat-release ]; then
    OS_TYPE="redhat"
elif [ -f /etc/debian_version ]; then
    OS_TYPE="debian"
else
    echo "Unsupported OS. Only RedHat-based and Debian-based systems are supported."
    exit 1
fi

echo "Detected OS type: $OS_TYPE"

# Install NTP package
if [ "$OS_TYPE" = "redhat" ]; then
    echo "Installing NTP on RedHat-based system..."
    sudo yum install -y ntp
    NTP_CONF="/etc/ntp.conf"
elif [ "$OS_TYPE" = "debian" ]; then
    echo "Installing NTP on Debian-based system..."
    sudo apt update
    sudo apt install -y ntp
    NTP_CONF="/etc/ntp.conf"
fi

# Backup original NTP config
if [ -f "$NTP_CONF" ]; then
    sudo cp "$NTP_CONF" "$NTP_CONF.bak.$(date +%F_%T)"
fi

# Replace server entries
sudo sed -i '/^server /d' "$NTP_CONF"

cat <<EOL | sudo tee -a "$NTP_CONF"
server 0.ir.pool.ntp.org iburst
server 1.ntp.day.ir iburst
server 2.asia.pool.ntp.org iburst
server 3.asia.pool.ntp.org iburst
server 0.pool.ntp.org iburst
server 1.pool.ntp.org iburst
server 2.pool.ntp.org iburst
server 3.pool.ntp.org iburst
EOL

echo "NTP servers updated successfully."

# Enable and start NTP service
if [ "$OS_TYPE" = "redhat" ]; then
    sudo systemctl enable ntpd
    sudo systemctl restart ntpd
elif [ "$OS_TYPE" = "debian" ]; then
    sudo systemctl enable ntp
    sudo systemctl restart ntp
fi

echo "NTP installation and configuration completed successfully."
