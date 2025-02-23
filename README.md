# Termux Debian XFCE Setup  

## Description  

This script sets up a **Debian XFCE** environment inside **Termux** on Android. It is designed for **installing browser extensions** to **farm airdrops** efficiently. The setup includes:  

- **Debian with XFCE desktop**  
- **Brave Browser** (pre-configured with `--no-sandbox`)  
- **VNC & Termux-X11 support** for graphical interface  
- **Custom scripts (`start`, `tx11`, and `vnc`)** for easy environment management  

## Installation  

Run the following command in **Termux**:  

```sh
curl -Lf "https://raw.githubusercontent.com/TimTini/AndroidNode/main/install.sh?$(date +%s)" -o install.sh
chmod +x install.sh
./install.sh
```  

This script will automatically install Debian, XFCE, Brave Browser, and necessary components.  

## Usage  

After installation, you can start the Debian environment with:  

```sh
start
```  

Then, launch the XFCE desktop using one of the following methods:  

- **Using Termux-X11** (requires Termux-X11 app):  

  ```sh
  tx11
  ```  

- **Using VNC Server** (connect with a VNC viewer to `localhost:1`):  

  ```sh
  vnc
  ```  

## Additional Information  

- **Pre-installed Brave Browser**: Allows installing **airdrops farming extensions** without restrictions.  
- **Custom Scripts (`start`, `tx11`, `vnc`)**: Simplifies launching the environment.  
- **Optimized for Android**: Runs inside Termux using Proot-Distro.
