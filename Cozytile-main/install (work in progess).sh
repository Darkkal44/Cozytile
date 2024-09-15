#!/bin/env bash
set -e

# Request sudo upfront
echo "This script requires sudo privileges."
sudo -v

echo "Welcome to the Cozytile Setup!" && sleep 2

# System update 
echo "Performing a full system update..."
sudo pacman --noconfirm -Syu

# Install Git if not present 
sudo pacman -S --noconfirm --needed git

# Clone and install Paru if not installed
if ! command -v paru &> /dev/null; then
    echo "Installing Paru, an AUR helper..."
    mkdir -p ~/.srcs
    git clone https://aur.archlinux.org/paru-bin.git ~/.srcs/paru-bin
    (cd ~/.srcs/paru-bin && makepkg -si --noconfirm)
fi


# Install base-devel and required packages
paru -S --noconfirm --needed base-devel qtile python-psutil pywal-git picom dunst zsh starship mpd ncmpcpp playerctl brightnessctl alacritty pfetch htop flameshot thunar roficlip rofi ranger cava pulseaudio pavucontrol neovim vim sddm

# Backup and install configuration files 
echo "Backing up and installing configuration files..."

# Backup and install fonts
mkdir -p ~/.local/share/fonts ~/.srcs
cp -r ./fonts/* ~/.local/share/fonts/
fc-cache -f

# Create a .backup directory in the home directory if it doesn't exist
mkdir -p ~/.backup

backup_and_install() {
    local folder="$1"
    local src_path="$2"

    if [ -d ~/$folder ]; then
        echo "$folder configs detected, backing up..."
        # Move existing configs to .backup
        mkdir -p ~/.backup/$folder
        mv ~/$folder/* ~/.backup/$folder/
    fi
    cp -r $src_path ~/$folder/
}

# Add all the necessary directories as seen in the folder structure
backup_and_install ".config/rofi" "./.config/rofi"
backup_and_install ".config/dunst" "./.config/dunst"
backup_and_install ".config/alacritty" "./.config/alacritty"
backup_and_install ".config/nvim" "./.config/nvim"
backup_and_install ".config/cava" "./.config/cava"
backup_and_install ".config/picom" "./.config/picom"
backup_and_install ".config/qtile" "./.config/qtile"
backup_and_install ".config/spicetify" "./.config/spicetify"
backup_and_install ".themes" "./themes"
backup_and_install ".zshrc" "./zshrc"
backup_and_install "Wallpapers" "./Wallpapers"
backup_and_install "Themes" "./Themes"

# Choose video driver (requires sudo for installing drivers)
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

# Set Zsh as the default shell 
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

# Install Oh My Zsh and plugins
echo "Installing Oh My Zsh and plugins..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Enable SDDM 
echo "Enabling SDDM to start on boot..."
sudo systemctl enable sddm

# Inform the user and prompt for automatic restart
echo "Installation is complete!"
echo "The system will restart in 5 seconds to apply the changes and start using SDDM."
sleep 5

# Restart the system
sudo reboot
