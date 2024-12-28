#!/bin/bash

# Displaying the header banner
echo -e "__________________________________________________"
echo -e ".          __     __          __    __   _____  "
echo -e ".   |     /  \\   /    |   |  /  \\  /  \`    |     "
echo -e ".   |           |     |---|        ---     |     "
echo -e ".   |___  \\__/   \\__  |   |  \\__/  .__/    |     "
echo -e "__________________________________________________"
echo -e ".   Localhost Installation Script for proot-distro       "
echo -e "-------------------------------------------------"
echo -e ". This script installs OpenSSH and required tools"
echo -e ". to use localhost.run for port forwarding.      "
echo -e "__________________________________________________"

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo -e "Error: Please run this script as root or use sudo."
    exit 1
fi

# Prompt user for email
read -p "[?] Enter your email for SSH key generation: " email

# Validate email input
if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo -e "\n[+] Email is valid. Proceeding with SSH key generation..."
else
    echo -e "\n[-] Invalid email address. Exiting script."
    exit 1
fi

# Generate SSH key
echo -e "\n[+] Generating SSH key with the provided email..."
ssh-keygen -t rsa -C "$email" -f /root/.ssh/id_rsa -N ""

# Display the generated public key
echo -e "\n[+] SSH Key successfully generated. Public key:"
echo -e "__________________________________________________"
cat /root/.ssh/id_rsa.pub
echo -e "__________________________________________________"

# Update and upgrade the system
echo -e "\n[+] Updating and upgrading the system..."
apt update && apt upgrade -y

# Install OpenSSH Server
echo -e "\n[+] Installing OpenSSH Server..."
apt install -y openssh-server

# Start the SSH server manually
echo -e "\n[+] Starting OpenSSH Server..."
/usr/sbin/sshd
if pgrep -x "sshd" > /dev/null; then
    echo "[+] OpenSSH is running."
else
    echo "[-] Failed to start OpenSSH. Please check manually."
    exit 1
fi

# Install required packages
echo -e "\n[+] Installing other required tools..."
apt install -y curl

# Display public SSH key and instructions
echo -e "-------------------------------------------------"
echo -e "Generated Public SSH Key:"
cat /root/.ssh/id_rsa.pub
echo -e "__________________________________________________"

echo -e "Signup at https://admin.localhost.run/#/login/email"
echo -e "and add your SSH key to localhost.run"

# Display instructions for using localhost.run
echo -e "\n[+] Installation complete! You can now use localhost.run."
echo -e "__________________________________________________"
echo -e ". To forward a local port (e.g., 8080), use:"
echo -e ". ssh -R 80:localhost:8080 localhost.run"
echo -e "__________________________________________________"
echo -e ". Thank you for using the Localhost Installer."
echo -e "-------------------------------------------------"

