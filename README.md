<a href='#'><img align="center" src="./Assets/preview.png" alt="Cozytile"></a>


<div align="left">

##### Hey there!! I've been working on a Qtile rice for a while now, and I'm excited to share it with you. I've always been fascinated by the way the bar works in Qtile, so that's what I focused on for this rice. I'm thrilled with the results, and I hope you'll be impressed too.

##### Qtile might not be the most popular window manager out there, but it's definitely worth checking out. It has some amazing features and possibilities, and I hope my rice will inspire you to give it a try. So without further ado, here's my Qtile rice - I'm excited to finally show it off! Thanks for taking the time to check it out.

</div>

<div align="center">

## INSTALLATION
</div>

### For Arch Linux users:

<details>
<summary><h3>Automated Installation </h3></summary>

###### This installation script is specifically designed for Arch Linux users, and I can only guarantee that it will work for a freshly installed system. If you've been using a different window manager, no worries - just be sure to take a complete backup of your current dots before running the script. And if you're already using Oh My Zsh, don't forget to remove that folder from your home directory

- Make the script executable
```sh
chmod +x install.sh
```

- Run the script

```sh 
./install.sh
```

###### Once the script finishes its work and launches SDDM, it's time to choose Qtile from the WM selector and dive right into the Amazing world of Qtile!
</details>

#### Manual Installation

###### Note: 
###### While this guide is primarily intended for Arch Linux users, If you're running a different OS like Fedora, NixOS, or Debian. You'll still be able to follow along and get a clear idea of how to set things up. (using your OS's package manager and other tools)

###### Keep in mind that this configuration is tailored to assume that the main files, like ".config", will be located in the home folder (~/). However, if that's not the case for you, don't worry - you'll just need to make a few manual adjustments to the dotfiles.

<details>
<summary><h3>Dependencies</h3></summary>

###### To get started, let's make sure we have all the necessary prerequisites. In this case, I'm using Paru as the AUR helper, but keep in mind that your system may require a different approach. 

- Installation using paru

```sh 
paru -Syu base-devel qtile python-psutil pywal-git picom-jonaburg-fix dunst zsh starship mpd ncmpcpp playerctl brightnessctl alacritty pfetch htop flameshot thunar roficlip rofi ranger cava pulseaudio pavucontrol neovim vim git
```
- Fonts required for the bar and other utils

 ➺ [Font Awesome](https://fontawesome.com/)

 ➺ [JetBrains Mono](https://www.jetbrains.com/lp/mono/)

###### Download the zip files for these fonts, extract them and put them into ``.local/share/fonts/`` or ``/usr/share/fonts/``

</details>


<details>
<summary><h3>Shell</h3></summary>

##### Next step is to install and setup the shell. 

- Change the default shell to Zsh
```sh 
chsh -s $(which zsh)
```

- Setting up Oh-my-zsh & plugins
```sh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

</details>

<details>
<summary><h3>Dotfiles</h3></summary>

###### With all the necessary prerequisites now installed, the next step is to replicate my setup by copying the dotfiles

- Clone the repo and cd into the cloned folder.
```sh
git clone https://github.com/Darkkal44/Cozytile 
cd Cozytile
```

###### Now that you're in the cloned folder, it's time to copy those files over to your home directory.

- Copy the files using cp
```sh
cp -R ./. ~/
```

</details>

<details>
<summary><h3>Final step</h3></summary>

###### Now that you're done with copying the dotfiles, it's time to hop into Qtile. This requires installing a display manager like sddm. Here are the steps to install sddm:

- Install it using paru
```sh
paru -Sy sddm
```

- Enable and start sddm

```sh
sudo systemctl enable sddm && sudo systemctl start sddm
```
###### Now that you're in the login screen of sddm, just select Qtile from wm selector, then login with your root password! viola ✨ 

- Enjoy!

##### Congratulations! You have successfully replicated my setup! Feel free to experiment with the configurations and enjoy!!!

</details>

---

<div align="center">

#### Thats all!! Have a nice day!

</div>
