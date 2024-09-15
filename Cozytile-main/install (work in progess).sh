#!/bin/env bash
set -e

# Request sudo upfront
echo "This script requires sudo privileges."
sudo -v

# Function to keep sudo alive while the script is running
keep_sudo_alive() {
    while true; do
        sudo -v
        sleep 60
    done
}
keep_sudo_alive &  # Run in the background

# Cleanup background sudo process on script exit
trap 'kill $(jobs -p)' EXIT

# Function to display a progress bar
show_progress() {
    local message=$1
    local progress=$2
    local total=$3
    local width=50
    local progress_width=$((width * progress / total))
    local remaining_width=$((width - progress_width))
    printf "%s [%-${width}s] %d%%\r" "$message" "$(printf "%${progress_width}s" "" | tr ' ' '#')" $((progress * 100 / total))
}

# Function to simulate work and update progress
progress_step() {
    local message=$1
    local steps=$2
    local total_steps=$3
    for ((step=1; step<=total_steps; step++)); do
        sleep 1  # Simulate work
        show_progress "$message" $step $total_steps
    done
    echo
}

echo "Welcome to the Qtile Rice Setup!" && sleep 2

# System update (requires sudo)
echo "Performing a full system update..."
progress_step "Updating system" 1 1
sudo pacman --noconfirm -Syu

# Install Git if not present (requires sudo)
echo "Installing Git if not present..."
progress_step "Installing Git" 1 1
sudo pacman -S --noconfirm --needed git

# Clone and install Paru if not installed
if ! command -v paru &> /dev/null; then
    echo "Installing Paru, an AUR helper..."
    mkdir -p ~/.srcs
    progress_step "Cloning Paru" 1 1
    git clone https://aur.archlinux.org/paru-bin.git ~/.srcs/paru-bin
    (cd ~/.srcs/paru-bin && makepkg -si --noconfirm)
fi

# Install base-devel and required packages
echo "Installing base-devel and required packages..."
progress_step "Installing packages" 1 1
paru -S --noconfirm --needed base-devel qtile python-psutil pywal-git picom-jonaburg-fix dunst zsh starship mpd ncmpcpp playerctl brightnessctl alacritty pfetch htop flameshot thunar roficlip rofi ranger cava pulseaudio pavucontrol neovim vim sddm

# Backup and install configuration files
echo "Backing up and installing configuration files..."
progress_step "Backing up and installing configs" 1 1

# Backup and install fonts
mkdir -p ~/.local/share/fonts ~/.srcs
progress_step "Installing fonts" 1 1
cp -r ./fonts/* ~/.local/share/fonts/
fc-cache -f

# Create a .backup directory in the home directory if it doesn't exist
mkdir -p ~/.backup

backup_and_install() {
    local folder="$1"
    local src_path="$2"

    if [ -d ~/$folder ]; then
        echo "$folder configs detected, backing up..."
        mkdir -p ~/.backup/$folder
        mv ~/$folder/* ~/.backup/$folder/
    fi
    cp -r $src_path ~/$folder/
}

# Add all the necessary directories
backup_and_install ".config/rofi" "./config/rofi"
backup_and_install ".config/dunst" "./config/dunst"
backup_and_install ".config/alacritty" "./config/alacritty"
backup_and_install ".config/nvim" "./config/nvim"
backup_and_install ".config/cava" "./config/cava"
backup_and_install ".config/picom" "./config/picom"
backup_and_install ".config/qtile" "./config/qtile"
backup_and_install ".config/spicetify" "./config/spicetify"
backup_and_install ".themes" "./themes"
backup_and_install ".zshrc" "./zshrc"
backup_and_install "wallpapers" "./wallpapers"
backup_and_install "Assets" "./Assets"
backup_and_install "Screenshots" "./Screenshots"
backup_and_install "Themes" "./Themes"

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
echo "Installing Xorg and video drivers..."
progress_step "Installing drivers" 1 1
sudo pacman -S --noconfirm --needed xorg xorg-xinit $DRI

# Set Zsh as the default shell
echo "Setting Zsh as the default shell..."
progress_step "Setting Zsh" 1 1
chsh -s $(which zsh)

# Install Oh My Zsh and plugins
echo "Installing Oh My Zsh and plugins..."
progress_step "Installing Oh My Zsh" 1 1
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Enable SDDM
echo "Enabling SDDM to start on boot..."
progress_step "Enabling SDDM" 1 1
sudo systemctl enable sddm

# Inform the user and prompt for automatic restart
echo "Installation is complete!"
echo "The system will restart in 5 seconds to apply the changes and start using SDDM."
sleep 5

# Restart the system
sudo reboot
