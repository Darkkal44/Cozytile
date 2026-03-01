<p align="center">
<pre align="center">
<a href="#setup">SETUP</a>  •  <a href="#keybinds">KEYBINDS</a>  •  <a href="#gallery">GALLERY</a>  •  <a href="#credits">CREDITS</a>
</pre>
</p>

<img id="gallery" align="center" src="./Assets/preview.png" alt="Cozytile" width="100%" style="border-radius: 10px; margin-top: 20px; margin-bottom: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);"/>

<p align="center">
  <a href="https://archlinux.org"><img src="https://img.shields.io/badge/ARCH_LINUX-000000?style=for-the-badge&logo=archlinux&logoColor=white"/></a>
  <a href="https://qtile.org"><img src="https://img.shields.io/badge/QTILE-000000?style=for-the-badge&logo=python&logoColor=white"/></a>
  <a href="https://github.com/Darkkal44/Cozytile/stargazers"><img src="https://img.shields.io/github/stars/Darkkal44/Cozytile?style=for-the-badge&color=000000"/></a>
</p>

</div>

---

<br>

<table width="100%">
<tr>
<td width="55%" valign="top">

### ☕ The Vision
A cozy rice to keep things comfy. I honestly think Qtile is way too underrated—being able to script your whole environment in Python is a superpower, and there's so much you can do with it. This is my take on showing off those possibilities with some clean, modern aesthetics.

### 🍁 Core Highlights
**Dynamic Themes:** `pywal` handles the heavy lifting—it pulls colors from your wallpaper and themes the whole system automatically.

**System Aware:** The bar is smart enough to know if you're on a Laptop or PC, so it swaps the battery and network widgets for you.

**Easy Deployment:** The installer script sets up everything—from GPU drivers to fonts and dotfiles—so you can get comfy faster.

</td>
<td width="45%" valign="top">

### 📚 The Stack

| Component | Choice |
| :--- | :--- |
| **Window Manager** | Qtile |
| **Compositor** | Picom |
| **Terminal** | Alacritty |
| **Launcher** | Rofi |
| **Shell** | Zsh + Starship |
| **Notifications** | Dunst |
| **File Manager** | Thunar |
| **Display Manager**| SDDM (Custom Themes) |
| **Audio** | MPD + Ncmpcpp + Cava |

</td>
</tr>
</table>

<br>

---

<div align="center">
  <h2 id="setup"> ☁️ DEPLOYMENT ☁️ </h2>
</div>

### 🌿 The Automated Path (Arch Linux)

> [!TIP]
> **Recommended:** For the purest experience, an automated installation script is provided. It handles AUR helpers, dependencies, custom SDDM themes, font caching, and Zsh configuration automatically.

```sh
# 1. Fetch the repository
git clone https://github.com/Darkkal44/Cozytile.git ~/.srcs/Cozytile
cd ~/.srcs/Cozytile

# 2. Run the deployment script
chmod +x install.sh
./install.sh
```

> [!IMPORTANT]
> Once the script finishes, you'll be greeted by SDDM. **Select `Qtile (Xorg)`** from the top-left corner before logging in. Do not use Qtile Wayland!

<br>

<details>
<summary><b>🌿 The Manual Path (Step-by-Step)</b></summary>
<br>

If you prefer knowing exactly what goes into your system or are adapting this setup for another OS, here is the exact manual breakdown of what the installer does.

**1. Base System Update & AUR Helper:**
If on Arch, ensure your system is updated and you have an AUR helper `yay` or `paru` installed:
```sh
sudo pacman -Syu --noconfirm
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/paru.git ~/.srcs/paru
cd ~/.srcs/paru && makepkg -si
```

**2. Core Dependencies & Fonts:**
Install the window manager, compositor, terminal, aesthetic tools, and all the required nerd fonts.
```sh
paru -S --needed qtile python-psutil pywal-git qt5-graphicaleffects picom dunst zsh starship mpd ncmpcpp playerctl brightnessctl alacritty pfetch htop flameshot thunar roficlip rofi ranger cava neovim vim feh sddm qt6-5compat qt6-declarative qt6-svg pipewire pipewire-pulse pamixer ttf-jetbrains-mono-nerd ttf-hack-nerd ttf-font-awesome ttf-firacode-nerd ttf-icomoon-feather
```

**3. [OPTIONAL] Adjusting Configurations by Device:**
- **Laptop users:** Skip this entire step, as the default widgets are configured for you.
- **PC users:** You can manually swap the battery module with the network module below. Make sure to apply this change to your main config (`~/.config/qtile/config.py`) as well as any individual theme configs located in `~/Themes/` subfolders.

<details>
<summary><b>Click for Desktop (Network) Widget Code</b></summary>

```python
widget.Net(
    font="JetBrainsMono Nerd Font Bold",
    fontsize=13,
    background="#353446",
    foreground="#CAA9E0",
    format=' {up}{up_suffix}  {down}{down_suffix}',
)
```
</details>

**4. Dotfiles & Config Placement:**
Fetch the setup and copy the necessary directories sequentially. Be sure to back up any existing files first!
```sh
git clone https://github.com/Darkkal44/Cozytile ~/.srcs/Cozytile
cd ~/.srcs/Cozytile

# Replicate configurations
cp -ra .config/* ~/.config/
cp -ra Wallpaper ~/
cp -ra Themes ~/
cp -a .zshrc ~/
```

**5. Update the Font Cache:**
Since we installed multiple fonts, rebuild the cache so Qtile and Alacritty can see them:
```sh
fc-cache -fv
```

**6. Graphics Drivers:**
Install the Xorg display server and proper drivers for your specific GPU.
```sh
# For Intel:
sudo pacman -S --needed xorg xorg-xinit xf86-video-intel

# For AMD:
sudo pacman -S --needed xorg xorg-xinit xf86-video-amdgpu

# For NVIDIA:
sudo pacman -S --needed xorg xorg-xinit nvidia-settings nvidia-utils
```

**7. Shell Framework (Zsh + Oh-My-Zsh):**
Initialize your shell aesthetics and install the required plugins.
```sh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

**8. SDDM Display Manager & Custom Themes:**
Enable SDDM, inject the handcrafted Cozy themes into the system theme directory, and allow your user to change SDDM themes without password authentication.
```sh
# Copy themes
sudo mkdir -p /usr/share/sddm/themes /etc/sddm.conf.d
sudo cp -r sddm-themes/* /usr/share/sddm/themes/

# Set 'Cozy' as the active theme
echo -e "[Theme]\nCurrent=Cozy" | sudo tee /etc/sddm.conf.d/theme.conf

# Setup sudoers automation for SDDM changes from UI
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/tee /etc/sddm.conf.d/theme.conf" | sudo tee /etc/sudoers.d/cozytile-sddm
sudo chmod 440 /etc/sudoers.d/cozytile-sddm

# Enable SDDM service
sudo systemctl enable sddm
```

**9. Preload Wallpaper Cache:**
To ensure system colors are ready to go immediately, generate `pywal` color caches for the included wallpapers.
```sh
wal -b 282738 -i ~/Wallpaper/Aesthetic2.png
wal -b 232A2E -i ~/Wallpaper/fog_forest_2.png
wal -i ~/Wallpaper/claudio-testa-FrlCwXwbwkk-unsplash.jpg
wal -b 282738 -i ~/Wallpaper/120_-_KnFPX73.jpg
wal -i ~/Wallpaper/a_road_going_through_a_desert.jpeg
wal --theme ~/.cache/wal/e-ink.json
```

**10. Finalize & Reboot:**
The most important step! Reboot your system to apply all changes and start your new journey with Cozytile!
```sh
sudo reboot
```

</details>

<br>

---

<div align="center">
  <h2 id="keybinds"> ⌨️ NAVIGATION MATRIX ⌨️ </h2>
  <p>Master your environment from the keyboard.</p>
</div>

<table align="center" width="100%">
  <tr>
    <td align="center" width="33%"><b>Focus & Groups</b></td>
    <td align="center" width="33%"><b>Window & Layout</b></td>
    <td align="center" width="33%"><b>System & Apps</b></td>
  </tr>
  <tr>
    <td valign="top">
      <br>
      <code>Super + h/j/k/l</code> Move Focus<br><br>
      <code>Super + [1-8]</code> Switch Group<br><br>
      <code>Super + Shift + [1-8]</code> Move to Group<br><br>
      <code>Super + Space</code> Next Window<br><br>
      <code>Super + f</code> Fullscreen<br>
    </td>
    <td valign="top">
      <br>
      <code>Super + Ctrl + h/j/k/l</code> Shift Window<br><br>
      <code>Super + Shift + h/j/k/l</code> Resize Window<br><br>
      <code>Super + n</code> Normalize Sizes<br><br>
      <code>Super + Shift + Enter</code> Toggle Split<br><br>
      <code>Super + Tab</code> Next Layout<br><br>
      <code>Super + c</code> Kill Window<br>
    </td>
    <td valign="top">
      <br>
      <code>Super + Enter</code> Alacritty Terminal<br><br>
      <code>Super + r</code> Rofi App Launcher<br><br>
      <code>Super + p</code> Rofi Powermenu<br><br>
      <code>Super + t</code> Theme Switcher<br><br>
      <code>Super + h</code> Clipboard Manager<br><br>
      <code>Super + e</code> Thunar File Manager<br><br>
      <code>Super + s</code> Flameshot (Screenshot)<br><br>
      <code>Super + Ctrl + r/q</code> Reload / Quit<br>
    </td>
  </tr>
</table>

<br>

---

<div align="center">
  <h2 id="credits"> 🌙 CREDITS & GRATITUDE 🌙 </h2>
</div>

A massive thank you to the **Unixporn Discord** community for the endless support and inspiration! This project wouldn't be the same without the kindness and knowledge shared there.

### SPONSORS
* **[Dominik](https://github.com/TheDomCraft)** — A huge thank you for your incredible kindness and the generous tip! ☕

### CONTRIBUTORS
* **phiumphium** — My good friend who spent countless hours helping me squash bugs and polish the experience. 🛠️

### SPECIAL THANKS
For their help with various some silly things:
* **[Namish](https://namishh.com/)**
* **[Stardust](https://star.is-a.dev/)**

---

<div align="center">
  <br>
  <p><i>Enjoy your stay. Keep it cozy.</i></p>
</div>
