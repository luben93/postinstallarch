#!/bin/bash
# post install for arch linux + awesome wm desktop, requires git
rooted (){
    pacman -Syu
    pacman -S sudo git vim zsh  tmux base-devel  --noconfirm
    pacman -S --noconfirm xorg-server awesome termite xterm xorg-xinit # graphical 
    if ! grep archlinuxfr /etc/pacman.conf 
    then echo '
        [archlinuxfr]
        SigLevel = Never
        Server = http://repo.archlinux.fr/$arch
        
        [multilib]
        Include = /etc/pacman.d/mirrorlist
        ' >> /etc/pacman.conf
    fi
    pacman -Sy yaourt --noconfirm
    
    echo '
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us,se"
        Option "XkbVariant" ","
        Option "XkbOptions" "grp:alt_shift_toggle"
EndSection' >> /etc/X11/xorg.conf.d/00-keyboard.conf

}

rooted 

