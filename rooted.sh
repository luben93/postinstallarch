#!/bin/bash
# post install for arch linux + awesome wm desktop, requires git
rooted (){
    pacman -Syu
    pacman -S sudo git vim zsh  tmux base-devel  --noconfirm
    pacman -S --noconfirm xorg-server awesome termite xterm xorg-xinit # graphical 
        echo '[archlinuxfr]
    SigLevel = Never
    Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
    pacman -Sy yaourt --noconfirm
}

headless() {
    yaourt -S --noconfirm dex htop-temperature atop cmatrix cowsay fortune dialog openssh iw curl \
    linux-headers ntfs-3g unzip transmission-cli wpa_supplicant hfsprogs  atop cmatrix cowsay fortune dialog openssh 
}

rooted 
headless 
