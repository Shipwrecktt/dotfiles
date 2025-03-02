AUR='yay -S --noconfirm'

install_yay() {
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru 
    makepkg -si --noconfirm

    if ! command -v yay &> /dev/null; then
        echo "yay could not be installed"
        exit 1
    fi
}

install_aur_packages() {
    $AUR wd719x-firmware upd72020x-fw yt-dlp-drop-in librewolf-bin
    echo "===================="
    echo "AUR packages setup"
    echo "===================="
}


main() {
    install_yay
    install_aur_packages
    echo "=================================="
    echo "Done installing"
    echo "=================================="
}

# Run the main script
main
