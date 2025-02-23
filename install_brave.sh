#!/bin/sh

# Function to install Brave Browser
install_brave() {
    echo "Installing Brave Browser..."
    curl -fsS https://dl.brave.com/install.sh | bash
}

# Function to find the Brave .desktop file
find_brave_desktop_file() {
    echo "Searching for Brave .desktop file..."
    find /usr/share/applications ~/.local/share/applications -name "brave-browser.desktop" 2>/dev/null | head -n 1
}

# Function to update Brave .desktop file to add --no-sandbox
update_brave_desktop() {
    local desktop_file="$1"

    if [ -n "$desktop_file" ]; then
        echo "Updating $desktop_file to add --no-sandbox..."
        sed -i 's|Exec=brave-browser %U|Exec=brave-browser --no-sandbox %U|' "$desktop_file"
        sed -i 's|Exec=/usr/bin/brave-browser-stable %U|Exec=/usr/bin/brave-browser-stable --no-sandbox %U|' "$desktop_file"
        # Update the application database cache
        update-desktop-database ~/.local/share/applications/
    else
        echo "Brave .desktop file not found!"
    fi
}

# Main execution flow
install_brave
BRAVE_DESKTOP=$(find_brave_desktop_file)
update_brave_desktop "$BRAVE_DESKTOP"
