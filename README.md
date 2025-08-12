


# NTP Server Installer & Configurator

This script automatically installs and configures **NTP (`ntpd`)** on both **RedHat-based** and **Debian-based** systems.  
It sets up Iran, Asia, and global pool servers for accurate and fast time synchronization, and can be used as both an **NTP client** and an **NTP server**.

## Features
- **OS detection** — works on both RedHat-based (CentOS, RHEL, Rocky, AlmaLinux) and Debian-based (Debian, Ubuntu) systems.
- **Automated installation** of the `ntp` package.
- **Pre-configured NTP servers**:


-server 0.ir.pool.ntp.org iburst

-server 1.ntp.day.ir iburst

-server 2.asia.pool.ntp.org iburst

-server 3.asia.pool.ntp.org iburst

-server 0.pool.ntp.org iburst

-server 1.pool.ntp.org iburst

-server 2.pool.ntp.org iburst

-server 3.pool.ntp.org iburst


- **Automatic backup** of the existing `/etc/ntp.conf`.
- **Service enable & start** on completion.

## Installation

```bash
git clone https://github.com/arynishere/ntp.git
cd ntp
chmod +x ntp-installation.sh
./ntp-installation.sh
````

> Make sure you run the script as a user with **sudo** privileges.

## Using as an NTP Server

By default, `ntpd` listens on all interfaces so other devices in your network can sync time.
If you want to allow specific subnets, edit `/etc/ntp.conf` and add:

```conf
restrict 192.168.0.0 mask 255.255.255.0 nomodify notrap
```

Also, open port **123/UDP**:

```bash
# RedHat-based
sudo firewall-cmd --permanent --add-service=ntp
sudo firewall-cmd --reload

# Debian-based (ufw)
sudo ufw allow 123/udp
```

## Requirements

* Root or sudo access
* Internet connection

