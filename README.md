# Dotfiles

This repository contains my personal configuration files (dotfiles) for various programs. These dotfiles are tailored to my preferences and setup, but you may find them useful as a reference or starting point for your own configurations, so you may use them as you wish!

## Warning
In my [xinitrc](files/config/X11/xinitrc) I have it set to the UK keyboard layout, so if your keyboard layout is diffrent change it there!

## Table of Contents
- [Installation](#installation)
- [Included Configurations](#included-configurations)
- [Contributing](#contributing)
- [License](#license)

## Installation
To install my dotfiles, follow these simple steps:

1. **Clone the Gitlab Repository:**

From Gitlab
    ```sh
    git clone https://gitlab.com/dotfiles
    cd dotfiles
    ```

From my website
    ```sh
    git clone git://git.shipwreckt.co.uk/dotfiles.git
    cd dotfiles
    ```

2. **Run the Install Script:**
    ```sh
    ./autoinstall.sh
    ```
    This script will install packages I use, set up UFW (Uncomplicated Firewall), install synth shell and yay, set up directories in your home directory, set up the LY display manager, and copy my configuration files to your `.config` plus some `.bashrc` additions I use.


## Included Configurations
This repository includes configurations for the following programs:

- [LY](https://github.com/fairyglade/ly) - Display Manager
- [Dircolors](https://www.gnu.org/software/coreutils/manual/html_node/dircolors-invocation.html) - Adds color in the terminal
- [Neovim](https://neovim.io/) - My IDE
- [Picom](https://github.com/yshui/picom) - Compositor for X, forked from Compton
- [Ranger](https://github.com/ranger/ranger) - TUI-based File Manager with Vim Keybinds
- [Redshift](https://github.com/jonls/redshift) - Adjusts the Color Temperature of Your Screen
- [DWM](https://dwm.suckless.org/) - Tiling Window Manager
- [Dmenu](https://tools.suckless.org/dmenu/) - App Launcher by Suckless
- [Slstatus](https://tools.suckless.org/slstatus/) - Status Bar for DWM
- [St](https://st.suckless.org/) - Terminal emulator by suckless
- [Fish shell](https://fishshell.com/) - Terminal shell
- [Starship](https://starship.rs/) - Terminal bling
- [Dunst](https://github.com/dunst-project/dunst) - Notifications
- [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp) - Kool TUI music player 

## Programs No Longer Used
These are programs and tools that I no longer use:

- [Alacritty](https://github.com/alacritty/alacritty) - Terminal
- [Polybar](https://github.com/polybar/polybar) - Simple Status Bar
- [Synth Shell](https://github.com/andresgongora/synth-shell) - Terminal Customization and Git Helper
- [i3](https://i3wm.org/) - Tiling Window Manager plus i3status
- [Qtile](https://qtile.org/) - Tiling Window Manager written in Python
- [Rofi](https://github.com/davatorium/rofi) - App Launcher

## Contributing
Contributions are welcome! However, please note that these are my personal dotfiles, so I will primarily accept changes that align with my preferences and style.

Feel free to submit pull requests or open issues if needed, and I'll review them as time allows.


## License
As with nearly all of my repositories, this one is licensed under the [GNU Affero General Public License v3.0](https://www.gnu.org/licenses/agpl-3.0.en.html). I'm including this notice to ensure that the license is clearly stated, in case the license file is not present in the repository.

Please refer to the [LICENSE](LICENSE) file for detailed information.
