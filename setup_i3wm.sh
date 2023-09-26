#!/bin/bash

# Step 1: Install Essential Programs
sudo apt update
sudo apt install i3 vim git meson gimp arandr nitrogen picom rofi thunar brightnessctl lxappearance vlc

# Step 2: Install i3-gaps (Airblader's version)
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev \
libstartup-notification0-dev

git clone https://github.com/Airblader/i3.git i3-gaps
cd i3-gaps
mkdir -p build && cd build
meson ..
ninja
sudo ninja install

# Step 3: Install Visual Studio Code
sudo snap install --classic code

# Step 4: Install i3lock-color
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color

# Build without installing
./build.sh

# OR, build AND install
# ./install-i3lock-color.sh

# Step 5: Configure touchpad for natural scrolling and tap to click
touchpad_config="/etc/X11/xorg.conf.d/90-touchpad.conf"
touchpad_config_content='Section "InputClass"\n    Identifier "touchpad"\n    Driver "libinput"\n    MatchIsTouchpad "on"\n    Option "NaturalScrolling" "true"\n    Option "Tapping" "true"\nEndSection'

echo -e "$touchpad_config_content" | sudo tee "$touchpad_config"

# Step 6: Mute the system bell
echo "xset -b" >> ~/.Xresources
xrdb ~/.Xresources

# Step 7: Change Wallpaper Using Nitrogen (GUI)
nitrogen

# Step 8: Copy Configuration Files
cp i3/config ~/.config/i3/
sudo cp i3status.conf /etc/
cp picom.conf ~/.config/
mkdir -p ~/.config/auto_start_script
cp disable_blank_screen.sh ~/.config/auto_start_script/
cp screenlayout.sh ~/.config/auto_start_script/

# Step 9: Install AwesomeFont (You need to provide the font files)

# Additional instructions may be needed to install fonts

# Print a completion message
echo "Setup completed! Please restart your system to apply all changes."
