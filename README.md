<a href='#'><img align="center" src="./Assets/Preview.png" alt="Cozytile"></a>


<div align="center">

### Hi there 👋 
</div>
<div align="center">

#### 🖤 Thank you for taking the time to check out my dots! I hope you enjoy it and find it inspiring! 🖤
             
---       
</div>



<div align="center">

## Installation
</div>

###### Note: This configuration is designed with the assumption that the main files, such as ".config", will be located in the home folder (~/). If this is not the case for you, then you may need to manually adjust the dotfiles

<details>
<summary><h3>Dependencies</h3></summary>

###### The first step is to install the necessary prerequisites. I am using an AUR helper called Paru, but please note that this may differ for you.

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
<summary><h3>Dotfiles</h3></summary>

###### Now that all the necessary prerequisites have been installed, the next step is to copy the dotfiles to replicate my setup! 

- Clone the repo and cd into the cloned folder.
```sh
git clone https://github.com/Darkkal44/CozyTile 
cd Cozytile
```

###### Now that you're in the cloned folder, choose the colorscheme that you'd like to install using the script

- Execute the script
```sh
chmod +x install
./install
```
###### This script not only provides you with a selection of colorschemes but also creates a backup of the configuration part that will be replaced. In case you want to revert back, the backup is easily available for you. Further details will be provided in the script itself.

- Restart your system
###### Now that the script has performed its magic, simply restart your system, and voila!

##### Congratulations! You have successfully replicated my setup! Feel free to experiment with the configurations and enjoy!!!

</details>
