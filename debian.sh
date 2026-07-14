# NOTE
## Currently this is just a mock up of what the script will look like, this script probably will not work, so be careful if you do run this script as of now.

DotfilesDir=$(pwd)
SucklessDir="$DotfilesDir/files/config/suckless"

# Install
install(){
  ## Updates packages
  sudo apt update
  sudo apt upgrade -y
  ## Installs packages
  sudo apt install -y picom ufw mpv redshift htop lxappearance wget libxrandr-dev grub-customizer taskwarrior thunderbird irssi wireguard dbus dbus-user-session xdotool dunst libnotify-bin dbus-x11 newsboat

  ## Gaming packages
  sudo apt install

  sudo dpkg --add-architecture i386
  sudo apt update

  sudo apt install -y mesa-vulkan-drivers vulkan-tools libvulkan1 mesa-utils mesa-utils libvkd3d1 libvkd3d1:i386
  sudo apt install -y gamemode mangohud

}


guix(){
  cd /tmp
  wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
  chmod +x guix-install.sh
  sudo ./guix-install.sh
  cd $DotfilesDir
}

secret_service(){
  # May replace with pass in the future
  libsecret-1-0 libsecret-1-dev seahorse gnome-keyring
}

yubikey(){
  ## Debian page for Yubikey: https://wiki.debian.org/Smartcards/YubiKey4
  ### Need to check that libu2f-host0 works.
  sudo cp $DotfilesDir/files/udev 99-yubikeys.rules /etc/udev/rules.d/
}

# Clamav
clamav(){
  ## Install
  sudo apt-get install clamav clamav-daemon curl

  ## Update database
  sudo systemctl stop clamav-freshclam
  sudo freshclam

  ## Enables clamav daemon
  sudo systemctl enable --now clamav-daemon
}

config(){

  ## Allows for DWM for display managers
  sudo mkdir -p /usr/share/xsessions
  sudo cp "$DotfilesDir/files/dwm.desktop" /usr/share/xsessions/

  ## Copy configs over
  mkdir ~/.config
  cp -rf $DotfilesDir/files/config/* ~/.config/

  ## Installs suckless software
    for dir in dwm slstatus dmenu slock ; do
      if cd "$SucklessDir/$dir"; then
        echo "Building $dir..."
        sudo make clean install || echo "Build failed in $dir"
      else
        echo " Directory not found: $SucklessDir/$dir"
      fi
    done

  ## Newsboat
  mkdir ~/.newsboat
  cp -rf $DotfilesDir/files/newsboat/* ~/.newsboat/

  ## Downloads Vimplug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  }

# ufw
ufw(){
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  # sudo ufw allow OpenSSH # Enables ssh
  sudo ufw logging medium # Enables logging
  sudo ufw enable
}


# Librewolf
librewolf(){
  ## https://librewolf.net/installation/debian/
  sudo apt update && sudo apt install extrepo -y
  sudo extrepo enable librewolf && sudo extrepo update librewolf
  sudo apt update && sudo apt install librewolf -y
}

# Updates permission
perms(){
  sudo chown -R "$USER":"$USER" "$HOME"
  sudo chmod 700 "$HOME"
}

home_directory() {
  mkdir -p ~/Documents/Passwords
  mkdir -p ~/Documents/Study
  mkdir -p ~/Documents/Projects
  mkdir -p ~/Documents/Notes
  mkdir -p ~/Documents/Books
  mkdir -p ~/Documents/Programming
  mkdir -p ~/Documents/Vimwiki
  mkdir -p ~/Downloads/
  mkdir -p ~/Videos/Personal
  mkdir -p ~/Music/
  mkdir -p ~/Games/
  mkdir -p ~/.config/
  touch ~/.bookmarks
  echo "=================="
  echo "Directories setup"
  echo "=================="
}


main(){
  install
  librewolf
  home_directory
  ufw
  config
  secret_service
  perms
}


# Calls main function
main
