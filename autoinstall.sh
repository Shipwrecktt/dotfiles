#!/bin/bash

set -e

INSTALL='sudo pacman -S --noconfirm'
UPDATE='sudo pacman -Syu --noconfirm'

install_packages() {
    $UPDATE
    $INSTALL mpv feh redshift linux-firmware-qlogic pavucontrol picom nitrogen thunar gvfs lxappearance alsa-utils neovim yubico-pam starship fish man-db qt5ct breeze breeze-gtk redshift htop lsb-release libreoffice-fresh ly ufw scrot keepassxc ranger unzip gcr webkit2gtk gd dosfstools xorg-xkill openresolv wireguard-tools libdvdcss libdvdread dunst cryptsetup wget mpc mpd ncmpcpp
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
    mkdir -p ~/Documents/passwords
    mkdir -p ~/Documents/projects
    mkdir -p ~/Documents/notes
    mkdir -p ~/Documents/books
    mkdir -p ~/Downloads/
    mkdir -p ~/Backups/
    mkdir -p ~/Programming/
    mkdir -p ~/Videos/personal
    mkdir -p ~/Music/
    mkdir -p ~/Games/
    echo "=================="
    echo "Directories setup"
    echo "=================="
}

copy_config_files() {
    sudo mkdir -p /usr/share/xsessions
    sudo cp ~/dotfiles/files/dwm.desktop /usr/share/xsessions/

    sudo cp -r ~/dotfiles/files/pacman.conf /etc/pacman.conf
    
    sudo cp -r ~/dotfiles/files/config/* ~/.config/
    sudo cp ~/dotfiles/files/Ly/config.ini /etc/ly/config.ini

    cd ~/dotfiles/files/config/suckless/dwm/
    sudo make clean install
    cd ../slstatus
    sudo make clean install
    cd ../dmenu
    sudo make clean install
    cd ../surf
    sudo make clean install
    cd ../st
    sudo make clean install
    cd ../scroll
    sudo make clean install
    
    # Ranger config
    ranger --copy-config=all
    rm -rf ~/.config/ranger/*
    sudo cp -r ~/dotfiles/files/ranger/* ~/.config/ranger/

    # Enable mpd for music junk
    sudo systemctl start mpd

    echo "=================="
    echo "Configs loaded"
    echo "=================="
}

fonts(){
  cp -rf ~/dotfiles/files/fonts ~/.fonts
}

bashrc_additions(){
  echo 'eval "$(dircolors ~/.config/dircolours)"' >> ~/.bashrc
  echo 'alias tree='pstree'' >> ~/.bashrc
  echo 'alias P="cd ~/Programming"' >> ~/.bashrc
  echo 'alias C="cd ~/.config"' >> ~/.bashrc
  echo 'alias vim='nvim'' >> ~/.bashrc
  echo "printf '\033[?1h\033= >/dev/tty'" >> ~/.bashrc
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

main() {
    install_packages
    setup_ufw
    setup_home_directory
    setup_ly
    copy_config_files
    fonts
    bashrc_additions
    fish
    Security
    echo "=================================="
    echo "Done installing, you may reboot."
    echo "Thank you for installing!"
    echo "=================================="
}

#This runs the script and gives the current user perms
main
sudo chown -R $(whoami):$(whoami) /home/$(whoami)
sh ~/dotfiles/yay.sh

