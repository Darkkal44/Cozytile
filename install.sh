#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if script is run as root
if [[ "$(id -u)" -eq 0 ]]; then
  echo -e "${RED}This script must not be run as root!${NC}"
  exit 1
fi

# Update system 
sudo pacman -Syu

# Install Git
if command -v git &>/dev/null; then
  echo -e "Git v${GREEN}$(git -v | cut -d' ' -f3)${NC} is already installed in your system"
else
  sudo pacman -S git
fi

# Clone and install Yay
if command -v yay &>/dev/null; then
  echo -e "Yay $(yay -V | cut -d' ' -f2) is installed in your system"
else
  echo -e "${RED}Yay is not present in your system.${NC}"
  echo -e "${YELLOW}Installing Yay...${NC}"
  git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
fi

# Install packages
echo -e "${YELLOW}Installing packages...${NC}"
yay -Syu base-devel qtile python-psutil pywal-git picom-jonaburg-git dunst zsh \
starship playerctl brightnessctl alacritty thunar rofi pipewire-pulse alsa-utils \
git sddm picom flameshot feh clipster roficlip pavucontrol firefox --needed --noconfirm

echo -e "${YELLOW}Installing fonts...${NC}"
yay -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk \
noto-fonts-emoji noto-fonts-extra

# Check and set Zsh as the default shell
[[ "$(awk -F: -v user="$USER" '$1 == user {print $NF}' /etc/passwd) " =~ "zsh " ]] || chsh -s $(which zsh)

# Install Oh My Zsh
if [ ! -d ~/.oh-my-zsh/ ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 
else
  omz update
fi

# Install Zsh plugins
echo "Installing zsh plugins"
[[ "${plugins[*]} " =~ "zsh-autosuggestions " ]] || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[[ "${plugins[*]} " =~ "zsh-syntax-highlighting " ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Make Backup 
echo -e "${YELLOW}Backing up the current configs. All the backup files will be available at ~/.cozy.bak${NC}"
mkdir -p ~/.cozy.bak

for folder in .* *; do
  if [[ -d "$folder" && ! "$folder" =~ ^(\.|\.\.)$ && "$folder" != ".git" ]]; then
    if [ -d "$HOME/$folder" ]; then
      echo "Backing up ~/$folder"
      cp -r "$HOME/$folder" ~/.cozy.bak
      echo "Backed up ~/$folder successfully."
      echo "Removing old config for $folder"
      rm -rf "$HOME/$folder"
    fi
    echo "Copying new config for $folder"
    cp -r "$folder" "$HOME"
  fi
done

# Check if SDDM is installed and install if not
if pacman -Qs sddm > /dev/null; then
  echo "${GREEN}SDDM is already installed${NC}"
else
  echo "${RED}SDDM is not installed. \n${YELLOW}Installing...${NC}"
  sudo pacman -S sddm
fi

# Disable currently enabled display manager
if systemctl list-unit-files | grep enabled | grep -E 'gdm|lightdm|lxdm|lxdm-gtk3|sddm|slim|xdm'; then
  echo -e "${YELLOW}Disabling currently enabled display manager${NC}"
  sudo systemctl disable --now $(systemctl list-unit-files | grep enabled | grep -E 'gdm|lightdm|lxdm|lxdm-gtk3|sddm|slim|xdm' | awk -F ' ' '{print $1}')
fi

# Enable and start SDDM
echo -e "${GREEN}Enabling and starting SDDM${NC}"
sudo systemctl enable --now sddm