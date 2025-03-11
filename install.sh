#!/bin/sh

# Function to update and install necessary packages in Termux
install_packages() {
    echo "Updating package lists and installing required packages..."
    termux-change-repo
    # common packages
    pkg update -y && pkg upgrade -y
    pkg install -y proot-distro pulseaudio x11-repo
    pkg install -y termux-x11-nightly
    # GPU packages
    pkg install tur-repo
    pkg install mesa-zink virglrenderer-mesa-zink vulkan-loader-android
    # Run the Zink test server
    MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless &

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
add_env_variable() {
    local var_name="$1"
    local var_value="$2"
    local bashrc_file="$HOME/.bashrc"

    # Kiểm tra xem biến đã tồn tại chưa
    if ! grep -q "export $var_name=" "$bashrc_file"; then
        echo "Thêm biến môi trường: $var_name"
        echo "export $var_name=\"$var_value\"" >> "$bashrc_file"
    else
        echo "Biến $var_name đã tồn tại trong $bashrc_file"
    fi
}

make_variable_environment() {
    add_env_variable "PATH" "$HOME/bin:$PATH"
}


# Function to install custom scripts (tx11 & vnc)
install_custom_scripts() {
    echo "Installing custom start script"

    mkdir -p "$HOME/bin"

    local login_url="https://raw.githubusercontent.com/TimTini/AndroidNode/main/login.sh"

    curl -Lf --progress-bar -o "$HOME/bin/start" "${login_url}?$(date +%s)"

    chmod +x "$HOME/bin/start"
}
# Main execution flow
install_packages
install_debian
# make_variable_environment
install_custom_scripts
setup_debian_script
run_debian_setup
# Download the start script
curl -Lf --progress-bar -o "$HOME/start.sh" "https://raw.githubusercontent.com/TimTini/AndroidNode/main/login.sh" && chmod +x "$HOME/start.sh"
# Log into Debian environment
echo "Logging into Debian..."
proot-distro login debian
