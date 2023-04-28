#!/bin/bash

# Check if script is run as root
if [[ "$(id -u)" -eq 0 ]]; then
  echo "This script must not be run as root"
  exit 1
fi

# Update system 
sudo pacman -Syu

# Install Git
if command -v git &>/dev/null; then
  echo "Git v$(git -v | cut -d' ' -f3) is already installed in your system"
else
  sudo pacman -S git --noconfirm
fi

# Clone and install Paru
if command -v paru &>/dev/null; then
  echo "Paru $(paru -V | cut -d' ' -f2) is already installed in your system"
else
  if command -v yay &>/dev/null; then
    echo "Yay $(yay -V | cut -d' ' -f2) is installed in your system"
  else
    echo "Neither Paru nor Yay is present in your system."
    echo "Installing Paru..."
    git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si --noconfirm && cd ..
  fi
fi 

# Install packages
sudo paru -Syu base-devel qtile python-psutil pywal-git picom-jonaburg-fix dunst zsh starship mpd ncmpcpp playerctl brightnessctl alacritty pfetch htop flameshot thunar roficlip rofi ranger cava pulseaudio pavucontrol neovim vim git sddm zsh-autosuggestions zsh-syntax-highlighting --noconfirm --needed

# Check and set Zsh as the default shell
[[ "$(awk -F: -v user="$USER" '$1 == user {print $NF}' /etc/passwd) " =~ "zsh " ]] || chsh -s $(which zsh)

# Install Oh My Zsh
if [ ! -d ~/.oh-my-zsh/ ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 
else
  omz update
fi

# Install Zsh plugins
[[ "${plugins[*]} " =~ "zsh-autosuggestions " ]] || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[[ "${plugins[*]} " =~ "zsh-syntax-highlighting " ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Make Backup
echo "Backing up the current configs. All the backeup files will be available at ~/.cozy.bak"
mkdir ~/.cozy.bak
for folder in .config/*; do
  rel=$(echo $folder | rev | cut -d/ -f1 | rev)
  if [ -d ~/.config/$rel ]; then
    echo "Backing up ~/.config/$rel"
    cp -r ~/.config/$rel ~/.cozy.bak
    echo "Backed up ~/.config/$rel successfully."
    echo "Removing old config for $rel"
    rm -rf ~/.config/$rel
    echo "Copying new config for $rel"
    cp -r .config/$rel ~/.config
  else
    echo "Folder ~/.config/$rel doesn't exist"
    echo "Copying new config for $rel"
    cp -r .config/$rel ~/.config
  fi
done

cp -R ~/Fonts/Jetbrains/ttf/. ~/.local/share/fonts/

# Enable and start SDDM
if is_installed sddm; then
  sudo systemctl disable --now lightdm 2>/dev/null || true
  sudo systemctl enable --now sddm
fi
