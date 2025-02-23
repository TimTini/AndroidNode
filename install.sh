#!/bin/sh

# Function to update and install necessary packages in Termux
install_packages() {
    echo "Updating package lists and installing required packages..."
    termux-change-repo
    pkg update -y && pkg upgrade -y
    pkg install -y proot-distro pulseaudio x11-repo
    pkg install -y termux-x11-nightly
}

# Function to install or reinstall Debian in proot-distro
install_debian() {
    if proot-distro list | grep -q debian; then
        echo "Debian is already installed."
    else
        echo "Installing Debian..."
        proot-distro install debian
    fi
}

# Function to download and setup the Debian installation script
setup_debian_script() {
    local script_url="https://raw.githubusercontent.com/TimTini/AndroidNode/main/debian-setup.sh"
    local script_path="$HOME/debian-setup.sh"

    echo "Downloading Debian setup script..."
    curl -Lf --progress-bar -o "$script_path" "${script_url}?$(date +%s)"
    chmod +x "$script_path"

    echo "Copying setup script into Debian environment..."
    proot-distro login debian -- cp "$script_path" "/root/debian-setup.sh"
}

# Function to execute the Debian setup script inside the proot-distro environment
run_debian_setup() {
    echo "Running Debian setup script inside Debian..."
    proot-distro login debian -- /bin/sh /root/debian-setup.sh
}

# Main execution flow
install_packages
install_debian
setup_debian_script
run_debian_setup

# Log into Debian environment
echo "Logging into Debian..."
proot-distro login debian
