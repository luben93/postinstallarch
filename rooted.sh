#!/bin/bash
# post install for arch linux + awesome wm desktop, requires git
rooted (){
    pacman -Syu
    pacman -S sudo git vim zsh  tmux base-devel  --noconfirm
    pacman -S --noconfirm xorg-server awesome termite xterm xorg-xinit # graphical 
    if ! grep archlinuxfr /etc/pacman.conf 
    then echo '[archlinuxfr]
        SigLevel = Never
        Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
    fi
    pacman -Sy yaourt --noconfirm
}

rooted 

