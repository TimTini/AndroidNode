#!/bin/sh

# Function to update package lists and install necessary dependencies
install_packages() {
    echo "Updating package lists and installing required packages..."
    apt update -y
    apt install -y curl xfce4 xfce4-goodies dbus-x11 tightvncserver autocutsel
}

# Function to install Brave Browser
install_brave() {
    echo "Installing Brave Browser..."
    sleep 1

    local brave_script="install_brave.sh"
    local brave_url="https://raw.githubusercontent.com/TimTini/AndroidNode/refs/heads/main/install_brave.sh"

    curl -Lf --progress-bar -o "$brave_script" "${brave_url}?$(date +%s)"
    chmod +x "$brave_script" && ./"$brave_script"
    rm -f "$brave_script"
}

# Function to configure VNC xstartup
setup_vnc_xstartup() {
    echo "Installing VNC server and setting up xstartup..."
    sleep 1

    local xstartup_url="https://raw.githubusercontent.com/TimTini/AndroidNode/main/xstartup"
    local xstartup_path="$HOME/.vnc/xstartup"

    mkdir -p "$HOME/.vnc"

    curl -Lf --progress-bar -o "$xstartup_path" "${xstartup_url}?$(date +%s)"
    chmod +x "$xstartup_path"
}

# Function to install custom scripts (tx11 & vnc)
install_custom_scripts() {
    echo "Installing custom scripts (tx11 & vnc)..."

    mkdir -p "$HOME/bin"

    local tx11_url="https://raw.githubusercontent.com/TimTini/AndroidNode/main/tx11.sh"
    local vnc_url="https://raw.githubusercontent.com/TimTini/AndroidNode/main/vnc.sh"

    curl -Lf --progress-bar -o "$HOME/bin/tx11" "${tx11_url}?$(date +%s)"
    curl -Lf --progress-bar -o "$HOME/bin/vnc" "${vnc_url}?$(date +%s)"

    chmod +x "$HOME/bin/tx11" "$HOME/bin/vnc"
}

# Function to update PATH variables
update_path() {
    echo "Updating PATH variables..."

    # Add ~/bin to PATH if not already present in .bashrc
    grep -qxF 'export PATH=$HOME/bin:$PATH' "$HOME/.bashrc" || echo 'export PATH=$HOME/bin:$PATH' >> "$HOME/.bashrc"

    # Add ~/bin to PATH if not already present in .profile
    grep -qxF 'export PATH=$HOME/bin:$PATH' "$HOME/.profile" || echo 'export PATH=$HOME/bin:$PATH' >> "$HOME/.profile"

    # Apply changes immediately for the current session
    export PATH="$HOME/bin:$PATH"
}

# Main execution flow
install_packages
install_brave
setup_vnc_xstartup
install_custom_scripts
update_path
