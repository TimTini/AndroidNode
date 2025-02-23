#!/bin/sh

# Function to install Brave Browser
install_brave() {
    echo "Installing Brave Browser..."
    curl -fsS https://dl.brave.com/install.sh | bash
}


# Function to update Brave .desktop file to add --no-sandbox
update_brave_desktop() {
    sed -i 's|Exec=/usr/bin/brave-browser-stable %U|Exec=/usr/bin/brave-browser-stable --no-sandbox %U|' /usr/share/applications/brave-browser.desktop
    # Update the application database cache
    update-desktop-database ~/.local/share/applications/
}

# Main execution flow
install_brave
update_brave_desktop