#!/bin/env bash
set -e

# Introduction & Warning
echo "Welcome to the Cozytile Setup!" && sleep 2
echo "Some parts of the script require sudo, so if you're planning on leaving the desktop while the installation script does its thing, better drop it already!." && sleep 4

# System update 
echo "Performing a full system update..."
sudo pacman --noconfirm -Syu
clear
echo "System update done" && sleep 2
clear

# Install Git if not present 
echo "Installing git..." && sleep 1
sudo pacman -S --noconfirm --needed git
clear

# Clone and install Paru if not installed
echo "This script requires an AUR helper to install the dependencies. Installing paru..." & sleep 2
if ! command -v paru &> /dev/null; then
    echo "Installing Paru, an AUR helper..."
    mkdir -p ~/.srcs
    git clone https://aur.archlinux.org/paru-bin.git ~/.srcs/paru-bin
    (cd ~/.srcs/paru-bin && makepkg -si --noconfirm)
    sudo ln -s /usr/lib/libalpm.so.15.0.0 /usr/lib/libalpm.so.14
fi
clear

# Install base-devel and required packages
echo "Installing dependencies.." && sleep 2
paru -S --noconfirm --needed base-devel qtile python-psutil pywal-git picom dunst zsh starship mpd ncmpcpp playerctl brightnessctl alacritty pfetch htop flameshot thunar roficlip rofi ranger cava neovim vim feh sddm
clear

# Backup and install configuration files 
echo "Backing up and installing configuration files..." && sleep 2

# Install fonts
mkdir -p ~/.local/share/fonts 
cp -r ./fonts/* ~/.local/share/fonts/
fc-cache -f

# Create or rename .backup directory
backup_dir="$HOME/.backup"
if [ -d "$backup_dir" ]; then
    echo "$backup_dir already exists. Renaming existing backup directory..."
    i=1
    while [ -d "$backup_dir.old.$i" ]; do
        i=$((i + 1))
    done
    mv "$backup_dir" "$backup_dir.old.$i"
fi
mkdir -p "$backup_dir"

backup_and_install() {
    local folder="$1"
    local src_path="$2"

    if [ -d ~/$folder ]; then
        echo "$folder configs detected, backing up..."
        # Move existing configs to .backup
        mkdir -p ~/.backup/$folder
        mv ~/$folder/* ~/.backup/$folder/
    fi
    mkdir -p ~/$folder
    cp -r $src_path/* ~/$folder/
}
backup_install_file() {
    local file="$1"
    local src_path="$2"

    if [ -f ~/$file ]; then
        echo "$file detected, backing up..."
        # Move existing file to .backup
        mkdir -p ~/.backup/$(dirname "$file")
        mv ~/$file ~/.backup/$(dirname "$file")/
    fi
    cp $src_path ~/$file
}


# Backing up & installing
backup_and_install ".config/rofi" "./.config/rofi"
backup_and_install ".config/dunst" "./.config/dunst"
backup_and_install ".config/alacritty" "./.config/alacritty"
backup_and_install ".config/cava" "./.config/cava"
backup_and_install ".config/picom" "./.config/picom"
backup_and_install ".config/qtile" "./.config/qtile"
backup_and_install ".config/spicetify" "./.config/spicetify"
backup_and_install "Wallpaper" "./Wallpaper"
backup_and_install "Themes" "./Themes"
backup_install_file ".config/starship.toml" "./.config/starship.toml"
sleep 2
clear

# Choose video driver
echo "1) xf86-video-intel 2) xf86-video-amdgpu 3) nvidia 4) Skip"
read -r -p "Choose your video card driver (default 1): " vid
case $vid in
    [1]) DRI='xf86-video-intel';;
    [2]) DRI='xf86-video-amdgpu';;
    [3]) DRI='nvidia nvidia-settings nvidia-utils';;
    [4]) DRI="";;
    *) DRI='xf86-video-intel';;
esac
sudo pacman -S --noconfirm --needed xorg xorg-xinit $DRI

clear

# Set Zsh as the default shell 
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

clear

# Install Oh My Zsh and plugins
if [ -d "~/.oh-my-zsh" ]; then
	rm -rf ~/.oh-my-zsh
fi
echo "Installing Oh My Zsh and plugins..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp -R .zshrc ~/

clear

# Enable SDDM 
echo "Enabling SDDM to start on boot..."
sudo systemctl enable sddm
clear

# Inform the user and prompt for automatic restart

echo "Pre-generating pywal colors..."
echo "Might take some time, hang on tight!"
wal -b 282738 -i ~/Wallpaper/Aesthetic2.png > /dev/null 2>&1
echo "Theme 1 ../done"
wal -b 282738 -i ~/Wallpaper/120_-_KnFPX73.jpg > /dev/null 2>&1
echo "Theme 2 ../done"
wal -i ~/Wallpaper/claudio-testa-FrlCwXwbwkk-unsplash.jpg > /dev/null 2>&1
echo "Theme 3 ../done"
wal -b 232A2E -i ~/Wallpaper/fog_forest_2.png > /dev/null 2>&1 
echo "Theme 4 ../done"

echo "Installation is complete!"
echo "The system will restart in 5 seconds to apply the changes and start using SDDM."
sleep 5

# Restart the system
sudo reboot
