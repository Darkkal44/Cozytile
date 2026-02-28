#!/bin/env bash
set -e

# Capture the exact directory where this installer is located
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Reset terminal colors on exit or crash
trap 'echo -ne "\033[0m"' EXIT

########################################
# Theme Palette
########################################

C_MAIN='\033[38;2;202;169;224m'
C_ACCENT='\033[38;2;145;177;240m'
C_DIM='\033[38;2;129;122;150m'
C_GREEN='\033[38;2;166;209;137m'
C_YELLOW='\033[38;2;229;200;144m'
C_RED='\033[38;2;231;130;132m'
C_BOLD='\033[1m'
C_RESET='\033[0m'

header() {
    clear
    echo -e "${C_MAIN}${C_BOLD}"
    echo " ╭──────────────────────────────────────────╮"
    echo " │          󱓞 COZYTILE INSTALLER 󱓞          │"
    echo " ╰──────────────────────────────────────────╯"
    echo -e "${C_RESET}"
}

info() {
    echo -e "${C_MAIN}${C_BOLD} ╭─ 󰓅 $1${C_RESET}"
}

substep() {
    echo -e "${C_MAIN}${C_BOLD} │  ${C_DIM}❯ ${C_RESET}$1"
}

success() {
    echo -e "${C_MAIN}${C_BOLD} ╰─ ${C_GREEN}✔ ${C_RESET}$1\n"
    sleep 0.5
}

warn() {
    echo -e "${C_MAIN}${C_BOLD} ╰─ ${C_YELLOW}⚠ ${C_RESET}$1\n"
}

error() {
    echo -e "${C_MAIN}${C_BOLD} ╰─ ${C_RED}✘ ${C_RESET}$1\n"
}

# Dim the noisy output of pacman/git commands
dim_on() { echo -ne "${C_DIM}"; }
dim_off() { echo -ne "${C_RESET}"; }

########################################
# Root Protection
########################################

if [[ $EUID -eq 0 ]]; then
   echo -e "${C_RED}${C_BOLD} ╭─ 🛑 CRITICAL ERROR${C_RESET}"
   echo -e "${C_RED}${C_BOLD} ╰─ Do NOT run this script as root. Use a standard user with sudo privileges.${C_RESET}"
   exit 1
fi

header
warn "This installer requires sudo privileges."

echo -e "${C_MAIN}${C_BOLD} ╭─ 󰪟 Select your Device Type${C_RESET}"
echo -e "${C_MAIN}${C_BOLD} │  ${C_ACCENT}1 ${C_DIM}❯ ${C_RESET}Laptop"
echo -e "${C_MAIN}${C_BOLD} │  ${C_ACCENT}2 ${C_DIM}❯ ${C_RESET}PC"
echo -ne "${C_MAIN}${C_BOLD} ╰─ ${C_YELLOW}Choice: ${C_RESET}"
read -rp "" device_choice
echo ""

info "Applying device-specific configuration fixes..."
find "$REPO_DIR" -name "config.py" | while read -r config_file; do
    substep "Patching $(basename "$config_file")"
    python3 -c "
import re, sys
path = sys.argv[1]
choice = sys.argv[2]
with open(path, 'r') as f: content = f.read()

battery_pattern = r'widget\.TextBox\(\s*text=\"\s*\",\s*font=\"Font Awesome 6 Free Solid\",\s*fontsize=13,\s*background=\"(?P<bg>[^\"]+)\",\s*foreground=\"(?P<fg>[^\"]+)\",\s*\),\s*widget\.Battery\(\s*font=\"JetBrainsMono Nerd Font Bold\",\s*fontsize=13,\s*background=\"(?P<bg2>[^\"]+)\",\s*foreground=\"(?P<fg2>[^\"]+)\",\s*format=\"\{percent:2\.0%\}\",\s*\)'
net_pattern = r'widget\.Net\(\s*font=\"JetBrainsMono Nerd Font Bold\",\s*fontsize=13,\s*background=\"(?P<bg>[^\"]+)\",\s*foreground=\"(?P<fg>[^\"]+)\",\s*format=[\'\"]\s*\s*\{up\}\{up_suffix\}\s*\s*\{down\}\{down_suffix\}[\'\"],\s*\)'

if choice == '2': # Laptop -> PC
    def sub_to_pc(m):
        bg = m.group('bg2')
        fg = m.group('fg2')
        return f'''widget.Net(
                    font=\"JetBrainsMono Nerd Font Bold\",
                    fontsize=13,
                    background=\"{bg}\",
                    foreground=\"{fg}\",
                    format=\' {{up}}{{up_suffix}}  {{down}}{{down_suffix}}\',
                )'''
    new_content = re.sub(battery_pattern, sub_to_pc, content, flags=re.DOTALL)
elif choice == '1': # PC -> Laptop
    def sub_to_laptop(m):
        bg = m.group('bg')
        fg = m.group('fg')
        return f'''widget.TextBox(
                    text=\" \",
                    font=\"Font Awesome 6 Free Solid\",
                    fontsize=13,
                    background=\"{bg}\",
                    foreground=\"{fg}\",
                ),
                widget.Battery(
                    font=\"JetBrainsMono Nerd Font Bold\",
                    fontsize=13,
                    background=\"{bg}\",
                    foreground=\"{fg}\",
                    format=\"{{percent:2.0%}}\",
                )'''
    new_content = re.sub(net_pattern, sub_to_laptop, content, flags=re.DOTALL)
else:
    new_content = content

with open(path, 'w') as f: f.write(new_content)
" "$config_file" "$device_choice"
done
success "Device type configurations applied."

########################################
# Full System Sync
########################################

info "Synchronizing system..."
dim_on
sudo pacman -Syu --noconfirm
dim_off
success "System updated successfully."

########################################
# Required Build Tools
########################################

info "Installing base build tools..."
dim_on
sudo pacman -S --needed --noconfirm git base-devel
dim_off
success "Base tools installed."

########################################
# AUR HELPER SETUP (Yay Priority)
########################################

info "Checking for AUR helper..."

install_yay() {
    substep "Building Yay from source..."
    dim_on
    rm -rf ~/.srcs/yay
    mkdir -p ~/.srcs
    git clone https://aur.archlinux.org/yay.git ~/.srcs/yay
    cd ~/.srcs/yay
    makepkg -si --noconfirm
    dim_off
}

install_paru() {
    substep "Building Paru from source..."
    dim_on
    rm -rf ~/.srcs/paru
    mkdir -p ~/.srcs
    git clone https://aur.archlinux.org/paru.git ~/.srcs/paru
    cd ~/.srcs/paru
    makepkg -si --noconfirm
    dim_off
}

if command -v yay &> /dev/null; then
    substep "Yay is already installed."
    AUR_HELPER="yay"
    success "Yay detected."
elif command -v paru &> /dev/null; then
    substep "Paru is already installed."
    AUR_HELPER="paru"
    success "Paru detected."
else
    if install_yay; then
        AUR_HELPER="yay"
        success "Yay installed successfully."
    else
        substep "${C_YELLOW}Yay failed. Attempting to build Paru...${C_RESET}"
        if install_paru; then
            AUR_HELPER="paru"
            success "Paru installed successfully."
        else
            error "Failed to install both Yay and Paru. Cannot continue."
            exit 1
        fi
    fi
fi

cd ~

########################################
# Install Dependencies
########################################

info "Installing Cozytile dependencies & Fonts..."
dim_on
$AUR_HELPER -S --noconfirm --needed \
qtile python-psutil python-pywal picom dunst zsh starship mpd ncmpcpp \
playerctl brightnessctl alacritty pfetch htop flameshot thunar \
roficlip rofi ranger cava neovim vim feh sddm pipewire pipewire-pulse \
pamixer ttf-jetbrains-mono-nerd ttf-hack-nerd ttf-font-awesome ttf-firacode-nerd ttf-icomoon-feather
dim_off
success "All dependencies and fonts installed."

########################################
# Config Backup & Install
########################################

info "Installing configuration files..."

BACKUP_DIR="$HOME/.backup/cozytile_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

install_item() {
    local item_path="$1"
    local target="$HOME/$item_path"
    local source="$REPO_DIR/$item_path"

    if [ ! -e "$source" ]; then
        substep "${C_YELLOW}Skipped:${C_RESET} $item_path (Not found in repo)"
        return
    fi

    if [ -e "$target" ] || [ -L "$target" ]; then
        mkdir -p "$(dirname "$BACKUP_DIR/$item_path")"
        mv "$target" "$BACKUP_DIR/$item_path"
        substep "Backed up: $item_path"
    fi

    mkdir -p "$(dirname "$target")"
    cp -a "$source" "$target"
    substep "${C_GREEN}Installed:${C_RESET} $item_path"
}

CONFIG_ITEMS=(
    ".config/fontconfig"
    ".config/rofi"
    ".config/dunst"
    ".config/alacritty"
    ".config/cava"
    ".config/picom"
    ".config/qtile"
    ".config/spicetify"
    "Wallpaper"
    "Themes"
    ".config/starship.toml"
)

for item in "${CONFIG_ITEMS[@]}"; do
    install_item "$item"
done

success "Dotfiles applied. Backups saved in ~/.backup/"

########################################
# Font Cache Update
########################################

info "Rebuilding font cache..."
dim_on
fc-cache -fv > /dev/null 2>&1
dim_off
success "Fonts loaded into system."

########################################
# GPU Driver
########################################

header
echo -e "${C_MAIN}${C_BOLD} ╭─ 󰪡 Select your GPU Driver${C_RESET}"
echo -e "${C_MAIN}${C_BOLD} │  ${C_ACCENT}1 ${C_DIM}❯ ${C_RESET}Intel"
echo -e "${C_MAIN}${C_BOLD} │  ${C_ACCENT}2 ${C_DIM}❯ ${C_RESET}AMD"
echo -e "${C_MAIN}${C_BOLD} │  ${C_ACCENT}3 ${C_DIM}❯ ${C_RESET}NVIDIA"
echo -e "${C_MAIN}${C_BOLD} │  ${C_ACCENT}4 ${C_DIM}❯ ${C_RESET}Skip / Virtual Machine"
echo -ne "${C_MAIN}${C_BOLD} ╰─ ${C_YELLOW}Choice (default 1): ${C_RESET}"
read -rp "" vid
echo ""

case "$vid" in
    2) DRI="xf86-video-amdgpu" ;;
    3) DRI="nvidia-settings nvidia-utils" ;;
    4) DRI="" ;;
    *) DRI="xf86-video-intel" ;;
esac

info "Installing Xorg and GPU stack..."
dim_on
sudo pacman -S --noconfirm --needed xorg xorg-xinit $DRI
dim_off
success "Graphics stack installed."

########################################
# Zsh Setup
########################################

info "Configuring Zsh framework..."
dim_on

chsh -s "$(which zsh)"
rm -rf "$HOME/.oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-autosuggestions \
${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

dim_off

if [ -f "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$BACKUP_DIR/.zshrc"
    substep "Backed up existing .zshrc"
fi

if [ -f "$REPO_DIR/.zshrc" ]; then
    cp "$REPO_DIR/.zshrc" "$HOME/.zshrc"
    substep "${C_GREEN}Installed:${C_RESET} Custom .zshrc"
fi

success "Zsh fully configured."

########################################
# Enable SDDM
########################################

info "Enabling Display Manager (SDDM)..."
dim_on
sudo systemctl enable sddm
dim_off
success "SDDM service enabled."

########################################
# Install SDDM Themes
########################################

info "Installing refined SDDM themes..."
dim_on
sudo mkdir -p /usr/share/sddm/themes
sudo cp -r "$REPO_DIR"/sddm-themes/* /usr/share/sddm/themes/
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=Cozy" | sudo tee /etc/sddm.conf.d/theme.conf
dim_off
success "SDDM themes installed and configured."

########################################
# Sudoers Automation (SDDM Sync)
########################################

info "Automating SDDM theme switching..."
dim_on
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/tee /etc/sddm.conf.d/theme.conf" | sudo tee /etc/sudoers.d/cozytile-sddm > /dev/null
sudo chmod 440 /etc/sudoers.d/cozytile-sddm
dim_off
success "Sudoers rule added for SDDM sync."

########################################
# Wallpaper Cache
########################################

info "Preloading wallpaper color cache..."
dim_on
substep "Aesthetic2.png"
wal -b 282738 -i ~/Wallpaper/Aesthetic2.png > /dev/null 2>&1 || true
substep "fog_forest_2.png"
wal -b 232A2E -i ~/Wallpaper/fog_forest_2.png > /dev/null 2>&1 || true
substep "claudio-testa"
wal -i ~/Wallpaper/claudio-testa-FrlCwXwbwkk-unsplash.jpg > /dev/null 2>&1 || true
substep "120"
wal -b 282738 -i ~/Wallpaper/120_-_KnFPX73.jpg > /dev/null 2>&1 || true
substep "a_road_going_through_a_desert"
wal -i ~/Wallpaper/a_road_going_through_a_desert.jpeg > /dev/null 2>&1 || true
substep "e-ink theme"
wal --theme ~/.cache/wal/e-ink.json > /dev/null 2>&1 || true
dim_off
success "Wallpaper cache preloaded."

########################################
# Finish
########################################

header
echo -e "${C_GREEN}${C_BOLD} ╭─ 󰗤 INSTALLATION COMPLETE!${C_RESET}"
echo -e "${C_GREEN}${C_BOLD} ╰─ Cozytile has been successfully configured.${C_RESET}\n"

echo -e "${C_MAIN}${C_BOLD} ╭─ 󰑓 REBOOTING${C_RESET}"
echo -e "${C_MAIN}${C_BOLD} │  ${C_DIM}System will restart in 5 seconds...${C_RESET}"
echo -e "${C_MAIN}${C_BOLD} ╰─ ${C_DIM}Press Ctrl+C to cancel reboot.${C_RESET}\n"

sleep 5
sudo reboot
