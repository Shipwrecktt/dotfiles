#!/bin/bash

set -e

DotfilesDir=$(pwd)
INSTALL='sudo pacman -S --noconfirm'
UPDATE='sudo pacman -Syu --noconfirm'
SucklessDir="$DotfilesDir/files/config/suckless"

install_packages() {
    $UPDATE
    $INSTALL mpv feh redshift linux-firmware-qlogic pavucontrol picom nitrogen thunar gvfs lxappearance alsa-utils neovim yubico-pam starship fish man-db qt5ct breeze breeze-gtk redshift htop lsb-release libreoffice-fresh ly ufw scrot keepassxc ranger unzip gcr webkit2gtk gd dosfstools xorg-xkill openresolv wireguard-tools libdvdcss libdvdread dunst cryptsetup wget ncmpcpp xclip xdotool xterm xorg-xclock xorg-twm okular thunderbird
    echo "=============================="
    echo "Programs are done installing"
    echo "============================="
}

setup_ufw() {
    sudo systemctl enable ufw
    sudo systemctl start ufw
    sudo ufw allow 22/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    echo "=================="
    echo "UFW setup is done"
    echo "=================="
}


setup_ly() {
    sudo systemctl enable ly
    echo "=================="
    echo "Done Ly setup!"
    echo "=================="
}


setup_home_directory() {
    mkdir -p ~/Documents/Passwords
    mkdir -p ~/Documents/Study
    mkdir -p ~/Documents/Projects
    mkdir -p ~/Documents/Notes
    mkdir -p ~/Documents/Books
    mkdir -p ~/Downloads/
    mkdir -p ~/Backups/
    mkdir -p ~/Programming/
    mkdir -p ~/Videos/Personal
    mkdir -p ~/Music/
    mkdir -p ~/Games/
    mkdir -p ~/.config/
    touch ~/.bookmarks
    echo "=================="
    echo "Directories setup"
    echo "=================="
}

copy_config_files() {
    sudo mkdir -p /usr/share/xsessions
    sudo cp "$DotfilesDir/files/dwm.desktop" /usr/share/xsessions/

    sudo cp -r "$DotfilesDir/files/pacman.conf" /etc/pacman.conf
    
    sudo cp -r "$DotfilesDir/files/config/*" ~/.config/
    sudo cp "$DotfilesDir/files/Ly/config.ini" /etc/ly/config.ini

    # Suckless software
    for dir in dwm slstatus dmenu surf st scroll; do
      if cd "$SucklessDir/$dir"; then
        echo "Building $dir..."
        sudo make clean install || echo "Build failed in $dir"
      else
        echo " Directory not found: $SucklessDir/$dir"
      fi
    done

    # Ranger config
    ranger --copy-config=all
    rm -rf ~/.config/ranger/*
    sudo cp -r "$DotfilesDir/files/ranger/*" ~/.config/ranger/

    # Install files for plug manager for NVIM
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    echo "=================="
    echo "Configs loaded"
    echo "=================="
}

fonts(){
  cp -rf "$DotfilesDir/files/fonts" ~/.fonts
}

bashrc_additions(){
  echo 'eval "$(dircolors ~/.config/dircolours)"' >> ~/.bashrc
  echo 'alias tree='pstree'' >> ~/.bashrc
  echo 'alias P="cd ~/Programming"' >> ~/.bashrc
  echo 'alias C="cd ~/.config"' >> ~/.bashrc
  echo 'alias vim='nvim'' >> ~/.bashrc
}

fish(){
  echo -e '\n# Start fish shell \nif [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]; then\n    shopt -q login_shell && LOGIN_OPTION="--login" || LOGIN_OPTION=""\n    exec fish $LOGIN_OPTION\nfi' >> ~/.bashrc
}

Blocked_Websites() {
  sudo chmod 666 /etc/hosts

  sudo echo "#Facebook" > /etc/hosts
  sudo echo "127.0.0.1 facebook.com login.facebook.com secure.facebook.com latest.facebook.com inyour.facebook.com beta.facebook.com static.facebook.com touch.facebook.com developers.facebook.com newsroom.fb.com pixel.facebook.com apps.facebook.com graph.facebook.com m.facebook.com upload.facebook.com"  >  /etc/hosts

  sudo chmod 644 /etc/hosts
}

Security() {
sudo sed -i '6 i auth optional pam_faildelay.so delay=4000000' /etc/pam.d/system-login
}

Doas() {
  $INSTALL opendoas
  echo "permit setenv {PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin} :wheel" > /etc/doas.conf 
  doas pacman -Rdd sudo
  doas ln -s $(which doas) /usr/bin/sudo
  doas chown -c root:root /etc/doas.conf
  doas chmod -c 0400 /etc/doas.conf

  # VIDOAS
  # Credit to https://www.cjjackson.dev/posts/replacing-sudo-with-doas-on-arch-linux/
  doas cp "$DotfilesDir/files/doas/vidoas" /root/script/vidoas
  doas cp "$DotfilesDir/files/doas/vidoas1" /usr/local/bin/vidoas

  doas chmod 700 /root/script/vidoas
  doas chmod 755 /usr/local/bin/vidoas
}
main() {
    install_packages
    setup_ufw
    setup_home_directory
    setup_ly
    copy_config_files
    fonts
    bashrc_additions
    fish
    setup_music
    Security
    echo "=================================="
    echo "Done installing, you may reboot."
    echo "Thank you for installing!"
    echo "=================================="
}

#This runs the script and gives the current user perms
main
sudo chown -R $(whoami):$(whoami) /home/$(whoami)
sh ~/Dotfiles/yay.sh

