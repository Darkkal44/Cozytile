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
paru -Syu base-devel qtile python-psutil pywal-git feh picom-jonaburg-git dunst zsh starship playerctl brightnessctl alacritty pfetch thunar rofi ranger cava pulseaudio alsa-utils neovim vim git sddm --noconfirm --needed

# Check and set Zsh as the default shell
[[ "$(awk -F: -v user="$USER" '$1 == user {print $NF}' /etc/passwd) " =~ "zsh " ]] || chsh -s $(which zsh)

# Install Oh My Zsh
if [ ! -d ~/.oh-my-zsh/ ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 
else
  omz update
fi

# Install Zsh plugins
<<<<<<< HEAD:install.sh
echo "Installing zsh plugins"
=======
<<<<<<< HEAD:install.sh
>>>>>>> parent of 59c16d9 (Synced:):install (work in progess).sh
=======
echo -e "${YELLOW}Installing zsh plugins${NC}"
>>>>>>> 59c16d9292c711cd50974fcaede9d2e007f24440:install (work in progess).sh
>>>>>>> e31c2f498b1c4660bf26a5aee0604bf432355330:install (work in progess).sh
[[ "${plugins[*]} " =~ "zsh-autosuggestions " ]] || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[[ "${plugins[*]} " =~ "zsh-syntax-highlighting " ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Make Backup 


echo "Backing up the current configs. All the backup files will be available at ~/.cozy.bak"
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
  echo "SDDM is already installed"
else
  echo "SDDM is not installed. Installing..."
  sudo pacman -S sddm
fi

# Disable currently enabled display manager
if systemctl list-unit-files | grep enabled | grep -E 'gdm|lightdm|lxdm|lxdm-gtk3|sddm|slim|xdm'; then
  echo "Disabling currently enabled display manager"
  sudo systemctl disable --now $(systemctl list-unit-files | grep enabled | grep -E 'gdm|lightdm|lxdm|lxdm-gtk3|sddm|slim|xdm' | awk -F ' ' '{print $1}')
fi

# Enable and start SDDM
echo "Enabling and starting SDDM"
sudo systemctl enable --now sddm

